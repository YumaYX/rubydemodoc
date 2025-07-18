import sys
from langchain_community.vectorstores import FAISS
from langchain_ollama import OllamaEmbeddings, OllamaLLM
from langchain.chains import RetrievalQA

PROMPT = (
    "Write about the following ruby codes in English using markdown format. Just the answer.\n"
    "Please omit backticks. Add a note to answer in complete sentences.\n"
    "Start your response with 'This Ruby code snippet demonstrates'.\n"
    "---\n"
)

def read_file(filepath):
    with open(filepath, "r", encoding="utf-8") as file:
        return file.read()

def build_rag_chain():
    embedder = OllamaEmbeddings(model="nomic-embed-text")
    vectorstore = FAISS.load_local("faiss_index", embedder, allow_dangerous_deserialization=True)
    retriever = vectorstore.as_retriever()
    llm = OllamaLLM(model="gemma3n")
    return RetrievalQA.from_chain_type(
        llm=llm,
        retriever=retriever,
        chain_type="stuff",
        return_source_documents=True
    )

def main():
    if len(sys.argv) < 2:
        print("Usage: python ask.py <ruby_file>")
        sys.exit(1)
    content = read_file(sys.argv[1])
    query = PROMPT + content
    rag_chain = build_rag_chain()
    result = rag_chain.invoke({"query": query})
    print(result["result"])
    
    docs = rag_chain.retriever.get_relevant_documents(query)
    context = "\n\n".join([doc.page_content for doc in docs])
    full_prompt = rag_chain.combine_documents_chain.llm_chain.prompt.format(
        context=context,
        question=query
    )
    print(full_prompt)


if __name__ == "__main__":
    main()
