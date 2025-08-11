tpope/vim-fugitive:
Git işlemlerini Vim içinde kolay yapmayı sağlar.
config fonksiyonunda iki kısayol tanımlanmış:

<leader>gg: Dikey bölmede :G komutunu çalıştırır (Fugitive Git arayüzü).

<leader>gb: :0G komutunu çalıştırır, buffer bazlı Fugitive.

'tpope/vim-rhubarb':
GitHub ile entegrasyon sağlayan ufak eklenti (örneğin, :Gbrowse komutu verir).
Burada sadece tanımlanmış, config verilmemiş.



----


numToStr/Comment.nvim, Neovim/Vim için satır ve blok yorumlama işlemlerini kolaylaştırır.

Hem normal modda hem de visual modda kısayollar sağlar.

Varsayılan kullanım:
Normal mod: gcc → Bulunduğun satırı yorumlar / yorumunu kaldırır

Visual mod: gc → Seçili satırları yorumlar / yorumunu kaldırır

Yani gcc tek satır, gc ise seçili alan üzerinde çalışır.
Dosya tipine göre doğru yorum işareti (//, #, -- vb.) otomatik seçilir.

---

nvim-telescope/telescope.nvim
-- Dosya arama
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Dosya Ara' })

-- Metin içinde arama
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Metin Ara' })

-- Açık buffer'lar arasında geçiş
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Buffer Ara' })

-- Yardım dökümanlarında arama
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help Ara' })


Kısayol	Komut / Fonksiyon	Açıklama
<leader>sh	help_tags	Neovim yardım dosyalarında arama yapar.
<leader>sk	keymaps	Tüm tanımlı keymap’leri listeler.
<leader>sf	find_files	Projede dosya ismine göre arar.
<leader>ss	builtin	Tüm Telescope picker’larını listeler.
<leader>sw	grep_string	İmlecin altındaki kelimeyi proje içinde arar.
<leader>sg	live_grep	Projede metin arar (ripgrep gerekir).
<leader>sd	diagnostics	LSP’den gelen hataları ve uyarıları listeler.
<leader>sr	resume	En son yapılan Telescope aramasını tekrar açar.
<leader>s.	oldfiles	Son açılan dosyaları listeler.
<leader><leader>	buffers	Açık buffer’lar arasında geçiş yapar.
<leader>/	current_buffer_fuzzy_find	Sadece açık olan buffer içinde bulanık arama yapar.
<leader>s/	live_grep { grep_open_files = true }	Sadece açık olan dosyalarda arama yapar.
<leader>sn	find_files { cwd = vim.fn.stdpath('config') }
