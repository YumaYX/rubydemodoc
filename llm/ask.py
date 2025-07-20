import sys
from langchain_community.vectorstores import FAISS
from langchain_ollama import OllamaEmbeddings, OllamaLLM
from langchain.chains import RetrievalQA

PROMPT = (
    "Write about the following ruby codes in English using markdown format. Just the answer.\n"
    "Start your response with 'This Ruby code snippet demonstrates'.\n"
    "---\n"
)

def read_file(filepath):
    with open(filepath, "r", encoding="utf-8") as file:
        return file.read()

def keyword_search(docs, query, k=5):
    # クエリを単語に分割
    keywords = set(query.lower().split())
    results = []
    for doc in docs:
        doc_text = doc.page_content.lower()
        if any(word in doc_text for word in keywords):
            results.append(doc)
        if len(results) >= k:
            break
    return results

def build_rag_chain():
    embedder = OllamaEmbeddings(model="nomic-embed-text")
    vectorstore = FAISS.load_local("faiss_index", embedder, allow_dangerous_deserialization=True)
    retriever = vectorstore.as_retriever(search_kwargs={"k": 40})
    llm = OllamaLLM(model="gemma3n")
    return vectorstore, retriever, llm

def main():
    if len(sys.argv) < 2:
        print("Usage: python ask.py <ruby_file>")
        sys.exit(1)
    content = read_file(sys.argv[1])
    query = PROMPT + content

    vectorstore, retriever, llm = build_rag_chain()
    # ベクトル検索
    vector_docs = retriever.get_relevant_documents(query)
    # すべてのドキュメントをロード
    all_docs = vectorstore.docstore._dict.values()
    # キーワード検索（Rubyコード部分のみで検索したい場合は適宜調整）
    keyword_docs = keyword_search(all_docs, content, k=1)
    # 結果をマージ（重複除去）
    all_results = {id(doc): doc for doc in vector_docs + keyword_docs}.values()

    # RetrievalQAで使うretrieverをカスタムする場合は独自実装が必要
    # ここでは単純にベクトル検索結果を使う例
    rag_chain = RetrievalQA.from_chain_type(
        llm=llm,
        retriever=retriever,
        chain_type="stuff",
        return_source_documents=True
    )
    result = rag_chain.invoke({"query": query})
    print(result["result"])

    # 参考: 両方の検索結果を表示
    print("\n--- Vector Search Results ---")
    for doc in vector_docs:
        print(doc.page_content[-200:], "\n---")
    print("\n--- Keyword Search Results ---")
    for doc in keyword_docs:
        print(doc.page_content[-200:], "\n---")

if __name__ == "__main__":
    main()