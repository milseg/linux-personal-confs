#!/bin/bash

# Verifica se os argumentos foram fornecidos
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Uso: $0 yyyy-mm-dd '*.extensão'"
  exit 1
fi

# Converte a data para o formato epoch
target_date=$(date -d "$1" +%s)

# Verifica se a conversão foi bem-sucedida
if [ $? -ne 0 ]; then
  echo "Data inválida. Por favor, use o formato yyyy-mm-dd."
  exit 1
fi

# Defina o padrão glob
glob_pattern=$2

# Encontra e remove arquivos criados antes da data especificada no diretório atual
for file in $glob_pattern; do
  if [ -f "$file" ]; then
    file_date=$(date -r "$file" +%s)
    if [ "$file_date" -lt "$target_date" ]; then
      rm "$file"
      echo "Removido: $file"
    fi
  fi
done

echo "Arquivos criados antes de $1 que correspondem ao padrão '$glob_pattern' foram removidos no diretório atual."

exit 0

