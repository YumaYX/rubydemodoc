import glob
from langchain_community.vectorstores import FAISS
from langchain_ollama import OllamaEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain.document_loaders import TextLoader

def load_documents(directory: str):
    """Load all documents from the specified directory."""
    file_paths = glob.glob(f"{directory}/*")
    documents = []
    for path in file_paths:
        loader = TextLoader(path, encoding="utf-8")
        documents.extend(loader.load())
    return documents

def split_documents(documents, chunk_size=500, chunk_overlap=50):
    """Split documents into chunks for embedding."""
    splitter = CharacterTextSplitter(chunk_size=chunk_size, chunk_overlap=chunk_overlap)
    return splitter.split_documents(documents)

def build_and_save_vectorstore(documents, index_path="faiss_index"):
    """Embed documents and save the FAISS vectorstore."""
    embedder = OllamaEmbeddings(model="nomic-embed-text")
    vectorstore = FAISS.from_documents(documents, embedder)
    vectorstore.save_local(index_path)

def main():
    docs = load_documents("docs")
    split_docs = split_documents(docs)
    build_and_save_vectorstore(split_docs)
    print("✅ Vectorstore creation and saving completed.")

if __name__ == "__main__":
    main()
