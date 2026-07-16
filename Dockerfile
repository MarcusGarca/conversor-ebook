# 1. Usa uma imagem oficial e leve do Python baseada em Debian (slim)
FROM python:3.10-slim

# 2. Instala o Calibre e dependências do sistema necessárias para a conversão
RUN apt-get update && apt-get install -y \
    calibre \
    && rm -rf /var/lib/apt/lists/*

# 3. Define o diretório de trabalho dentro do container
WORKDIR /app

# 4. Copia o arquivo de requisitos e instala as dependências do Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código da aplicação para o container
COPY . .

# 6. Expõe a porta padrão que o Streamlit usa
EXPOSE 8501

# 7. Comando para rodar a aplicação Streamlit apontando para a porta correta
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]