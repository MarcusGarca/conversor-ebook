# 📚 Conversor de E-books para PDF

Uma aplicação web moderna, simples e eficiente para converter e-books nos formatos `.epub` e `.mobi` para `.pdf`. O projeto utiliza **Python** e **Streamlit** para a interface do usuário, e o motor de conversão profissional do **Calibre CLI** (`ebook-convert`) para garantir que a formatação, sumários e imagens dos livros sejam preservados com alta fidelidade.

Este repositório já está totalmente configurado e otimizado para rodar em containers **Docker** e hospedagem na plataforma **Render**.

---

## 🛠️ Tecnologias Utilizadas

* **Python 3.10**: Linguagem de programação principal.
* **Streamlit**: Framework rápido e interativo para criação da interface web.
* **Calibre (CLI)**: Motor de conversão robusto de nível industrial que gerencia a conversão de formatos de e-books de maneira perfeita.
* **Docker**: Para empacotamento da aplicação e garantia de funcionamento idêntico entre o ambiente local e de produção.
* **Render**: Plataforma PaaS utilizada para hospedagem gratuita e deploy contínuo baseado em Git.

---

## 📁 Estrutura do Projeto

```text
conversor-ebook/
├── app.py                # Código-fonte da aplicação Streamlit e lógica de conversão
├── Dockerfile            # Configuração de ambiente e dependências do container Docker
├── requirements.txt      # Dependências do Python (Streamlit)
└── README.md             # Documentação do projeto (este arquivo)
```

---

## 🐳 Executando localmente com Docker

No diretório do projeto, execute os comandos abaixo para construir e subir o container localmente:

```bash
docker build -t conversor-local .
docker run --rm -p 8501:8501 --name conversor-ebook conversor-local
```

Depois disso, abra no navegador:

```text
http://localhost:8501
```

Se quiser parar o container, use:

```bash
docker stop conversor-ebook
```