# 1. Usa uma imagem oficial e leve do Python baseada em Debian (slim)
FROM python:3.10-slim

# 2. Instala o Calibre e dependências de bibliotecas gráficas virtuais
RUN apt-get update && apt-get install -y \
    calibre \
    xvfb \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libnss3 \
    libxcomposite1 \
    libxrandr2 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# 3. Define variáveis de ambiente para desativar GPU e forçar modo headless do Qt/Calibre
ENV QT_QPA_PLATFORM=offscreen
ENV QT_XCB_GL_INTEGRATION=none
ENV CALIBRE_USE_SYSTEM_THEME=1
ENV XDG_RUNTIME_DIR=/tmp/runtime-root
ENV QTWEBENGINE_DISABLE_SANDBOX=1
ENV QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox --disable-gpu --headless --disable-dev-shm-usage"
ENV LIBGL_ALWAYS_SOFTWARE=1

# 4. Define o diretório de trabalho dentro do container
WORKDIR /app

# 5. Copia o arquivo de requisitos e instala as dependências do Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copia o restante do código da aplicação para o container
COPY . .

# 7. Expõe a porta padrão que o Streamlit usa
EXPOSE 8501

# 8. Comando para rodar a aplicação Streamlit apontando para a porta correta
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]