<div align="center">

# SIGA Keep Alive

App Flutter simples para manter sua sessão do SIGA ativa.

</div>

## Como funciona

O [SIGA (Centro Paula Sousa)](https://siga.cps.sp.gov.br/) expira a sessão quando você fecha o navegador. Este app mantém uma WebView em background para manter sua sessão ativa, mesmo com o app minimizado.

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
