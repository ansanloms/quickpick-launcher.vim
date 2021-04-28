function! quickpick#pickers#launcher#open(bang, ...) abort
  call quickpick#open({
  \ "items": s:get_items(a:bang, get(a:000, 0, "")),
  \ "on_accept": function("s:on_accept"),
  \ "key": "view",
  \ "maxheight": get(g:, "quickpick_launcher_maxheight", 10),
  \})
endfunction

function! s:get_items(bang, ...) abort
  let l:config_file = get(g:, "quickpick_launcher_file", "~/.quickpick-launcher")

  let l:profile = get(a:000, 0, "")
  if !empty(l:profile)
    let l:config_file .= "-" . l:profile
  endif

  let l:file = fnamemodify(expand(l:config_file), ":p")

  let l:list = filereadable(l:file) ? filter(
  \ map(readfile(l:file), {
  \   v -> call({
  \     l -> {
  \       "view": len(l) >= 1 && l[0] !~ "^#" ? l[0] : v:null,
  \       "command": len(l) >= 2 && l[1] !~ "^#" ? l[1] : v:null,
  \     }
  \   }, [split(iconv(v:val, "utf-8", &encoding), "\\t\\+")])
  \ }), {
  \   v -> v:val["view"] != v:null && v:val["command"] != v:null
  \ }
  \) : []

  if empty(a:bang)
    let l:list += [{
    \ "view": "--edit-menu--",
    \ "command": printf("botright split %s", fnameescape(l:config_file))
    \}]
  endif

  return l:list
endfunction

function! s:on_accept(data, name) abort
  call quickpick#close()

  let l:cmd = a:data["items"][0]["command"]
  if l:cmd =~ "^!"
    silent exe l:cmd
  else
    exe l:cmd
  endif
endfunction
