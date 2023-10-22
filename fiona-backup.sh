#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------#
# Autor             : Joao Rodrigues <jvitor.lr@hotmail.com>                                #
# Homepage          : https://jvlr95.github.io/                                             #
# Linkedin          : https://www.linkedin.com/in/joao-rodrigues-4865441a2/                 #
# DATA-DE-CRIAÇÃO   : 2023-10-22                                                            #
# Descrição         : Fiona é programa destinado a automatizar processo de backup em        #
#                     sistemas Linux, de uma forma facil e eficiente.                       #
# Licença           : MIT (https://opensource.org/licenses/MIT)                             #
#                     Este software está sujeito aos termos da Licença MIT.                 #
#                     Veja o arquivo LICENSE para mais detalhes.                            #
#-------------------------------------------------------------------------------------------#

#Variáveis de ambiente----------------------------------------------------------------------#
source_dir="/home/$USER/"                         # Diretório a ser copiado
dest_dir="/mnt/sdb1/"                             # Diretório de destino (hd externo)
log_dir="/var/log/sistema-backup"                 # Diretorio pra salvar logs
log_file="/var/log/sistema-backup/backup.log"     # Nome do arquivo de log
#-------------------------------------------------------------------------------------------#

#Criando um diretotio para os logs----------------------------------------------------------#
if [ ! -d "$log_dir" ]; then
  sudo mkdir -p "$log_dir"
  sudo chown $USER:$USER "$log_dir"
fi

#Função para registrar mensagens no arquivo de log------------------------------------------#
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

#Registrar mensagem de início no log--------------------------------------------------------#
log "Iniciando backup de $source_dir para $dest_dir"

#Validando diretório de origem--------------------------------------------------------------#
if [ ! -d "$source_dir" ]; then
  log "Diretório de origem não encontrado: $source_dir"
  exit 1
fi

#Validando diretório de destino-------------------------------------------------------------#
if [ ! -d "$dest_dir" ]; then
  log "Diretório de destino não encontrado: $dest_dir"
  exit 1
fi

#Criando um diretório para o backup com data e hora-----------------------------------------#
timestamp=$(date +'%Y%m%d%H%M%S')
backup_dir="$dest_dir/backup_$timestamp"
mkdir -p "$backup_dir"

#Copiando com segurança os arquivos de /home/$USER para o diretório de backup---------------#
rsync -av --progress "$source_dir/" "$backup_dir/"

#Validando a cópia--------------------------------------------------------------------------#
if [ $? -eq 0 ]; then
  log "Backup concluído com sucesso em $backup_dir"
else
  log "Falha na criação do backup"
  exit 1
fi

#Remover backups excedentes-----------------------------------------------------------------#
num_backups=$(find "$dest_dir" -maxdepth 1 -type d -name "backup_*" | wc -l)
if [ "$num_backups" -gt 2 ]; then
  backups_to_remove=$(find "$dest_dir" -maxdepth 1 -type d -name "backup_*" | sort | head -n -2)
  for backup in $backups_to_remove; do
    rm -r "$backup"
    log "Backup antigo removido: $backup"
  done
fi

#Registrar mensagem de conclusão no log-----------------------------------------------------#
log "Backup concluído"
