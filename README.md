# Sistema de Backup Automatizado em Linux - FIONA

Este script foi desenvolvido para automatizar o processo de backup em sistemas Linux de uma forma fácil e eficiente. Ele usa o utilitário `rsync` para copiar os arquivos do diretório de origem para um diretório de destino (pode ser um HD externo, por exemplo) e mantém um registro de todas as operações em um arquivo de log. 

## Como usar o script

1. **Configuração inicial**:

   Antes de usar o script, você deve fazer algumas configurações iniciais. Abra o script em um editor de texto e ajuste as variáveis de ambiente de acordo com as suas necessidades:

   - `source_dir`: O diretório que você deseja copiar.
   - `dest_dir`: O diretório de destino onde os backups serão armazenados.
   - `log_dir`: O diretório onde os arquivos de log serão salvos.
   - `log_file`: O nome do arquivo de log.

   Certifique-se de que o usuário que executará o script tenha permissões adequadas para os diretórios de origem e destino.

2. **Agendando backups com o Crontab**:

   Para automatizar o processo de backup, você pode usar o utilitário Crontab para agendar a execução periódica do script. Aqui estão alguns exemplos de como adicionar uma tarefa ao Crontab:

   - **Diariamente**:

     Para executar o script diariamente, abra o Crontab com o comando:

     ```bash
     crontab -e
     ```

     E adicione a seguinte linha:

     ```bash
     0 1 * * * /bin/bash /caminho/para/o/seu/script.sh
     ```

     Isso executará o script todos os dias às 1h da manhã. Você pode ajustar o horário de acordo com suas preferências.

   - **Semanalmente**:

     Para executar o script semanalmente, adicione a seguinte linha ao Crontab:

     ```bash
     0 1 * * 0 /bin/bash /caminho/para/o/seu/script.sh
     ```

     Isso executará o script todos os domingos (o valor `0` no campo do dia da semana indica domingo) às 1h da manhã. Você pode ajustar o horário e o dia da semana conforme necessário.

   - **Mensalmente**:

     Para executar o script mensalmente, adicione a seguinte linha ao Crontab:

     ```bash
     0 1 1 * * /bin/bash /caminho/para/o/seu/script.sh
     ```

     Isso executará o script no primeiro dia de cada mês, às 1h da manhã. Você pode ajustar o horário e o dia do mês conforme necessário.

   Lembre-se de substituir `/caminho/para/o/seu/script.sh` pelo caminho completo para o seu script.

## Licença

Este software está disponível sob a [Licença MIT](https://opensource.org/licenses/MIT). Consulte o arquivo `LICENSE` para obter mais detalhes.

## Informações adicionais

- **Autor**: Joao Rodrigues
- **Homepage**: [https://jvlr95.github.io/](https://jvlr95.github.io/)
- **LinkedIn**: [https://www.linkedin.com/in/joao-rodrigues-4865441a2/](https://www.linkedin.com/in/joao-rodrigues-4865441a2/)
- **Data de Criação**: 2023-10-22
