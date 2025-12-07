<div align="center">

# SIGA Keep Alive

### v1.0.2

App Flutter simples para manter sua sessão do SIGA ativa.

</div>

## Como funciona

O [SIGA (Centro Paula Sousa)](https://siga.cps.sp.gov.br/) expira a sessão quando você fecha o navegador. Este app mantém uma WebView em background para manter sua sessão ativa, mesmo com o app minimizado.

## Instalação

### Via Release

1. Acesse a [página de releases](https://github.com/Lucasbc47/siga-keep-alive/releases)
2. Baixe o arquivo APK da versão mais recente
3. Instale o APK no seu dispositivo Android

### Compilar do código-fonte

## Como usar

1. Abra o app e faça login no SIGA através do botão da Microsoft
2. Use normalmente e minimize o app quando terminar
3. Na próxima vez que abrir, sua sessão ainda estará ativa

## Compilar

```bash
flutter pub get
flutter run
```

### Para Android:

```bash
flutter build apk
# ou
flutter build appbundle
```

## Sobre o projeto

Este projeto foi desenvolvido por **Lucas Costa**, motivado por um outro projeto que fazia a mesma coisa. Como gostaria de ver uma solução open source, resolvi fazer minha própria versão e disponibilizá-la para outros estudantes!

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
