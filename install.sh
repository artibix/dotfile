#!/bin/bash
# 定义颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 获取脚本所在目录的绝对路径
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_PATH")"

# 如果脚本就在dotfiles目录中运行
if [ "$(basename "$SCRIPT_PATH")" = "dotfile" ] || [ "$(basename "$SCRIPT_PATH")" = "dotfiles" ]; then
  DOTFILES_DIR="$SCRIPT_PATH"
fi

HOME_DIR="$HOME"
echo "${YELLOW}dotfiles目录: $DOTFILES_DIR${NC}"
echo "${YELLOW}Home目录: $HOME_DIR${NC}"

# 创建软链接的函数
create_symlink() {
  local source_file="$1"
  local target_file="$2"

  # 如果目标文件已存在且不是软链接，则备份
  if [ "$target_file" ] && [ ! -L "$target_file" ]; then
    echo "${YELLOW}备份已存在的 $target_file 为 $target_file.bak${NC}"
    mv "$target_file" "$target_file.bak"
  fi

  # 如果软链接已存在，则先删除
  if [ -L "$target_file" ]; then
    echo "${YELLOW}移除已存在的软链接 $target_file${NC}"
    rm "$target_file"
  fi

  # 创建软链接
  echo "${GREEN}创建软链接: $source_file -> $target_file${NC}"
  ln -s "$source_file" "$target_file"
}

# 链接配置文件的函数
link_config() {
  local file="$1"
  local target_dir="${2:-$HOME_DIR}"
  local target_path="$target_dir/$(basename "$file")"

  if [ "$DOTFILES_DIR/$file" ]; then
    create_symlink "$DOTFILES_DIR/$file" "$target_path"
  else
    echo "${RED}$file 不存在于dotfiles目录${NC}"
  fi
}

# 链接配置目录的函数
link_config_dir() {
  local dir="$1"
  local target_parent="${2:-$HOME_DIR/.config}"
  local target_path="$target_parent/$(basename "$dir")"

  # 确保目标父目录存在
  mkdir -p "$target_parent"

  if [ -d "$DOTFILES_DIR/$dir" ]; then
    create_symlink "$DOTFILES_DIR/$dir" "$target_path"
  else
    echo "${RED}$dir 目录不存在于dotfiles目录${NC}"
  fi
}

echo "开始安装dotfiles..."

# 配置文件列表
config_files=(".zshrc" ".vimrc" ".tmux.conf" ".gitconfig" ".fdignore" ".ideavimrc")

# 安装配置文件
for file in "${config_files[@]}"; do
  link_config "$file"
done

# 可选配置文件
optional_files=(".gitconfig-work")
for file in "${optional_files[@]}"; do
  if [ -f "$DOTFILES_DIR/$file" ]; then
    link_config "$file"
  else
    echo "${YELLOW}$file 不存在于dotfiles目录，跳过${NC}"
  fi
done

# 安装配置目录
link_config_dir "nvim"

echo "${GREEN}dotfiles安装完成!${NC}"
