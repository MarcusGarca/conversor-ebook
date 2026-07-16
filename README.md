# 📚 Conversor de E-books para PDF

Uma aplicação web moderna, simples e eficiente para converter e-books nos formatos `.epub` e `.mobi` para `.pdf`. O projeto utiliza **Python** e **Streamlit** para a interface do usuário, e o motor de conversão profissional do **Calibre CLI** (`ebook-convert`) para garantir que a formatação, sumários e imagens dos livros sejam preservados com alta fidelidade.

Este repositório está configurado para permitir tanto o **teste local via Docker** quanto a **hospedagem gratuita de alta performance** no **Streamlit Community Cloud**.

---

## 🛠️ Tecnologias Utilizadas

* **Python 3.10**: Linguagem de programação principal.
* **Streamlit**: Framework interativo para a interface web do usuário.
* **Calibre (CLI)**: Motor de conversão robusto de nível industrial que gerencia a conversão de formatos de e-books de maneira perfeita.
* **Docker**: Para empacotamento e garantia de funcionamento do ambiente em testes locais.
* **Streamlit Community Cloud**: Hospedagem oficial, gratuita e de alta performance com suporte nativo a pacotes Linux.

---

## 📁 Estrutura do Projeto

```text
conversor-ebook/
├── app.py                # Código-fonte da aplicação Streamlit e lógica de conversão
├── Dockerfile            # Configuração de ambiente para teste local com Docker
├── requirements.txt      # Dependências do Python (Streamlit)
├── packages.txt          # Dependências do sistema Linux para o Streamlit Cloud (Calibre)
└── README.md             # Documentação do projeto (este arquivo)
```

---

## 🐳 Executando localmente com Docker

Se você preferir rodar a aplicação em um ambiente isolado na sua máquina sem precisar instalar o Calibre diretamente no seu sistema operacional, utilize o Docker.

No diretório do projeto, execute os comandos abaixo para construir e subir o container localmente:

```bash
# Constrói a imagem Docker localmente
docker build -t conversor-local .

# Inicializa o container mapeando a porta do Streamlit
docker run --rm -p 8501:8501 --name conversor-ebook conversor-local
```

Depois disso, abra no seu navegador:
👉 **http://localhost:8501**

Se quiser parar o container, utilize o comando:
```bash
docker stop conversor-ebook
```

---

## 🚀 Publicando em Produção (Streamlit Community Cloud)

A hospedagem no **Streamlit Community Cloud** é totalmente gratuita, oferece excelente poder de processamento de CPU e disponibiliza **1 GB de memória RAM** (o dobro em comparação a outros planos gratuitos do mercado), garantindo conversões rápidas de livros complexos.

### Passo 1: Enviar o código para o GitHub
Para hospedar no plano gratuito do Streamlit, o seu repositório precisa ser **Público** no GitHub. Certifique-se de realizar o push dos arquivos atualizados:

```bash
git add .
git commit -m "feat: adiciona suporte ao streamlit cloud e packages.txt"
git push origin master
```

### Passo 2: Publicar no Streamlit Cloud
1. Acesse **[share.streamlit.io](https://share.streamlit.io/)** e faça login utilizando sua conta do GitHub.
2. No painel, clique no botão **"Create app"** (ou "New app") no canto superior direito.
3. Preencha as configurações apontando para o seu repositório:
   * **Repository:** Escolha o seu repositório `conversor-ebook`.
   * **Branch:** `master` (ou `main`).
   * **Main file path:** `app.py`.
4. Clique no botão azul **"Deploy!"**.

O Streamlit Cloud lerá automaticamente o arquivo `packages.txt`, fará a instalação do Calibre no servidor Linux deles e, em seguida, instalará os pacotes do `requirements.txt`. O deploy inicial leva cerca de 2 a 3 minutos.

---

## 💡 Informações Importantes sobre Desempenho
Para que as conversões na nuvem sejam extremamente rápidas sem sobrecarregar a memória do servidor gratuito, o comando de conversão está otimizado com as flags `--disable-font-subsetting` (evita o reprocessamento demorado de fontes embutidas) e `--pdf-sans-family Arial` (padroniza a fonte padrão do PDF final).