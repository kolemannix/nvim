return {
 cmd = { 'rust-analyzer' },
 filetypes = { 'rust' },
 root_markers = { 'Cargo.toml' },
 -- Server-specific settings...
 settings = {
   ["rust-analyzer"] = {
     cargo = {
       features = { "lsp" }
     },
     -- enable clippy on save
     -- checkOnSave = true,
     hover = {
       memoryLayout = {
         niches = true
       }
     },
     check = {
       command = "clippy"
     },
     diagnostics = {
       enable = true,
     },
     inlayHints = {
       chainingHints = {
         enable = false
       },
       discriminantHints = {
         enable = true
       },
       parameterHints = {
         enable = true
       },
       implicitDrops = true

     },
   }
 },
 capabilities = capabilities,
 on_attach = on_attach
}
