return {
 	vim.keymap.set({'n','i', 'v'}, '<Left>', ':echo "NO LEFT FOR YOU!"<Cr>'),
 	vim.keymap.set({'n','i', 'v'}, '<Right>', ':echo "NO RIGHT FOR YOU!"<Cr>'),
 	vim.keymap.set({'n','i', 'v'}, '<Up>', ':echo "NO UP FOR YOU!"<Cr>'),
 	vim.keymap.set({'n','i', 'v'}, '<Down>', ':echo "NO DOWN FOR YOU!"<Cr>'),
-- 
-- 	function arrow_toggle()
-- 		if vim.opt["arrow"]:get() == "off" then
-- 			vim.opt["arrow"] = "on"
-- 			vim.keymap.set({'n','i', 'v'}, '<Left>', '<Left>')
-- 			vim.keymap.set({'n','i', 'v'}, '<Right>', '<Right>')
-- 			vim.keymap.set({'n','i', 'v'}, '<Up>', '<Up>')
-- 			vim.keymap.set({'n','i', 'v'}, '<Down>', '<Down>')
-- 		end
-- 
-- 	end
}
