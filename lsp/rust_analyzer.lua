return {
 cmd = { 'rust-analyzer' },
 filetypes = { 'rust' },
 root_markers = { 'Cargo.toml' },
 -- Server-specific settings...
 settings = {
   ["rust-analyzer"] = {
     cargo = {
       features = "all"
     },
     -- enable clippy on save
     hover = {
       memoryLayout = {
         niches = true,
         padding = "both",
       }
     },
     completion = {
       fullFunctionSignatures = {
         enable = true
       },
       postfix = {
         enable = false
       },
       privateEditable = {
         enable = true
       }
     },
     checkOnSave = true,
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
