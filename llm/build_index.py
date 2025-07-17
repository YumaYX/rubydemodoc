import glob
from langchain_community.vectorstores import FAISS
from langchain_ollama import OllamaEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain.document_loaders import TextLoader

# 1. Markdownファイルを読み込む
file_paths = glob.glob("docs/*")
all_docs = []

for path in file_paths:
    loader = TextLoader(path, encoding="utf-8")
    all_docs.extend(loader.load())

# 2. チャンク分割（長文対応）
splitter = CharacterTextSplitter(chunk_size=500, chunk_overlap=50)
split_docs = splitter.split_documents(all_docs)

# 3. 埋め込みモデル（Ollama）
embedder = OllamaEmbeddings(model="nomic-embed-text")

# 4. ベクトルストア作成（FAISS）
vectorstore = FAISS.from_documents(split_docs, embedder)

# 5. 保存（デフォルトはindex.faiss / index.pkl）
vectorstore.save_local("faiss_index")

print("✅ ベクトルストアの作成と保存が完了しました。")
