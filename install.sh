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
if [ "$(basename "$SCRIPT_PATH")" = "dotfile" ]; then
  DOTFILES_DIR="$SCRIPT_PATH"
fi

HOME_DIR="$HOME"

echo -e "${YELLOW}dotfiles目录: $DOTFILES_DIR${NC}"
echo -e "${YELLOW}Home目录: $HOME_DIR${NC}"

# 创建软链接的函数
create_symlink() {
  local source_file="$1"
  local target_file="$2"

  # 如果目标文件已存在且不是软链接，则备份
  if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
    echo -e "${YELLOW}备份已存在的 $target_file 为 $target_file.bak${NC}"
    mv "$target_file" "$target_file.bak"
  fi

  # 如果软链接已存在，则先删除
  if [ -L "$target_file" ]; then
    echo -e "${YELLOW}移除已存在的软链接 $target_file${NC}"
    rm "$target_file"
  fi

  # 创建软链接
  echo -e "${GREEN}创建软链接: $source_file -> $target_file${NC}"
  ln -s "$source_file" "$target_file"
}

echo "开始安装dotfiles..."

# 链接zsh配置
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
  create_symlink "$DOTFILES_DIR/.zshrc" "$HOME_DIR/.zshrc"
else
  echo -e "${RED}.zshrc 不存在于dotfiles目录${NC}"
fi

# 链接vim配置
if [ -f "$DOTFILES_DIR/.vimrc" ]; then
  create_symlink "$DOTFILES_DIR/.vimrc" "$HOME_DIR/.vimrc"
else
  echo -e "${RED}.vimrc 不存在于dotfiles目录${NC}"
fi

# 链接tmux配置
if [ -f "$DOTFILES_DIR/.tmux.conf" ]; then
  create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME_DIR/.tmux.conf"
else
  echo -e "${RED}.tmux.conf 不存在于dotfiles目录${NC}"
fi

# 链接gitconfig
if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
  create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME_DIR/.gitconfig"
else
  echo -e "${RED}.gitconfig 不存在于dotfiles目录${NC}"
fi

if [ -f "$DOTFILES_DIR/.gitconfig-work" ]; then
  create_symlink "$DOTFILES_DIR/.gitconfig-work" "$HOME_DIR/.gitconfig-work"
else
  echo -e "${YELLOW}.gitconfig-work 不存在于dotfiles目录，跳过${NC}"
fi

# 链接nvim配置
if [ -d "$DOTFILES_DIR/nvim" ]; then
  # 确保.config目录存在
  mkdir -p "$HOME_DIR/.config"
  create_symlink "$DOTFILES_DIR/nvim" "$HOME_DIR/.config/nvim"
else
  echo -e "${RED}nvim 目录不存在于dotfiles目录${NC}"
fi

if [ -f "$DOTFILES_DIR/.fdignore" ]; then
  create_symlink "$DOTFILES_DIR/.fdignore" "$HOME_DIR/.fdignore"
else
  echo -e "${RED}.fdignore 不存在于dotfiles目录${NC}"
fi

echo -e "${GREEN}dotfiles安装完成!${NC}"
