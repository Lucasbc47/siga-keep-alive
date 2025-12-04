# SIGA Keep Alive

App Flutter simples para manter sua sessão do SIGA ativa.

## Como funciona

O problema: O site da FATEC (SIGA) expira a sessão quando você fecha o navegador, provavelmente usando cookies de sessão ou detectando o fechamento do navegador.

A solução: Este app mantém uma WebView aberta em background. Enquanto o app estiver rodando (mesmo minimizado), a sessão permanece ativa.

## Como usar

1. Abra o app
2. Faça login no SIGA normalmente através da WebView
3. Clique no ícone de "olho" no canto superior direito para minimizar a visualização
4. Minimize o app (não force o fechamento)
5. Sua sessão permanecerá ativa enquanto o app estiver em background

## Limitações

- **No Windows**: Não é possível testar o comportamento de background adequadamente, pois o Flutter desktop não simula o comportamento de apps mobile
- **No Android**: Funciona perfeitamente! Apenas minimize o app normalmente
- Se você **matar o app** (force stop), a sessão será perdida
- O Android pode matar o app automaticamente se precisar de memória

## Dicas para Android

Para evitar que o Android mate o app em background:

1. Vá em **Configurações → Apps → SIGA Keep Alive**
2. Em **Bateria**, selecione "Sem restrições" ou "Otimização desativada"
3. Mantenha o app minimizado, não o mate manualmente

## Compilar

```bash
flutter pub get
flutter run
```

Para Android:
```bash
flutter build apk
# ou
flutter build appbundle
```

## Dependências

- `flutter_inappwebview`: Para renderizar o site do SIGA com suporte completo a cookies e sessões

## Por que essa abordagem?

Tentamos gerenciar cookies manualmente, mas:
- Cookies de sessão podem ter flags HttpOnly (inacessíveis via JavaScript)
- O servidor pode detectar patterns suspeitos
- Cookies podem depender de headers específicos da requisição original

A solução mais confiável é simplesmente manter o navegador aberto, exatamente como o site espera.
