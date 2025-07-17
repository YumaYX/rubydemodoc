import sys
from langchain_community.vectorstores import FAISS
from langchain_ollama import OllamaEmbeddings, OllamaLLM
from langchain.chains import RetrievalQA

# 1. Embeddingモデルを準備
embedder = OllamaEmbeddings(model="nomic-embed-text")

# 2. 保存されたFAISSを読み込む（dangerous deserialization に注意）
vectorstore = FAISS.load_local("faiss_index", embedder, allow_dangerous_deserialization=True)

# 3. Retrieverを作成
retriever = vectorstore.as_retriever()

# 4. LLM（Ollamaモデル）
llm = OllamaLLM(model="gemma3n")

# 5. RetrievalQAチェーンを作成
rag_chain = RetrievalQA.from_chain_type(
    llm=llm,
    retriever=retriever,
    chain_type="stuff",
    return_source_documents=True
)

# 6. 質問を実行（`.invoke()` を使用）
query = sys.argv[1]
result = rag_chain.invoke({"query": query})

# 7. 結果表示
print(result["result"])
