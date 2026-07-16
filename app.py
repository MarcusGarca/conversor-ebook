import streamlit as st
import os
import subprocess
import tempfile

# Configuração da página do Streamlit
st.set_page_config(page_title="Conversor de E-books", page_icon="📚", layout="centered")

st.title("📚 Conversor de E-books para PDF")
st.write("Envie arquivos nos formatos **.epub** ou **.mobi** e baixe a versão convertida em PDF.")

# Componente de upload de arquivos
arquivo_enviado = st.file_uploader("Arraste ou selecione o seu e-book", type=["epub", "mobi"])

if arquivo_enviado is not None:
    # Cria uma pasta temporária segura para processar os arquivos
    with tempfile.TemporaryDirectory() as pasta_temp:
        caminho_entrada = os.path.join(pasta_temp, arquivo_enviado.name)
        nome_base, _ = os.path.splitext(arquivo_enviado.name)
        caminho_saida = os.path.join(pasta_temp, f"{nome_base}.pdf")
        
        # Grava o arquivo enviado na pasta temporária
        with open(caminho_entrada, "wb") as f:
            f.write(arquivo_enviado.getbuffer())
            
        st.info(f"Arquivo '{arquivo_enviado.name}' carregado com sucesso!")
        
        # Botão para iniciar a conversão
        if st.button("🚀 Converter para PDF"):
            with st.spinner("Processando conversão com o Calibre... Isso pode levar alguns segundos dependendo do tamanho do livro."):
                
                # Comando otimizado para rodar no Streamlit Cloud
                comando = [
                    "ebook-convert", 
                    caminho_entrada, 
                    caminho_saida,
                    "--pdf-sans-family", "Arial"  # Usa uma fonte padrão e rápida
                ]
                
                resultado = subprocess.run(comando, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                
                if resultado.returncode == 0:
                    st.success("🎉 Conversão concluída com sucesso!")
                    
                    # Disponibiliza o download do PDF gerado
                    with open(caminho_saida, "rb") as pdf_file:
                        st.download_button(
                            label="📥 Baixar seu PDF",
                            data=pdf_file,
                            file_name=f"{nome_base}.pdf",
                            mime="application/pdf"
                        )
                else:
                    st.error("Ocorreu um erro interno durante a conversão do arquivo.")
                    # Exibe o erro técnico para ajudar no diagnóstico se necessário
                    st.code(resultado.stderr, language="bash")