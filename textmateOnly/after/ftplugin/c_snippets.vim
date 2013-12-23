if !exists('loaded_snippet') || &cp
    finish
endif

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! CArgList(count)
    " This returns a list of empty tags to be used as
    " argument list placeholders for the call to printf
    let st = g:snip_start_tag
    let et = g:snip_end_tag
    if a:count == 0
        return ""
    else
        return repeat(', '.st.et, a:count)
    endif
endfunction

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet do do {<CR>".st.et."<CR>} while (".st.et.");"
exec "Snippet while while (".st.et.") {<CR>".st.et."<CR>}"
exec "Snippet readfile std::vector<uint8_t> v;<CR>if (FILE* fp = fopen(\"".st."filename".et."\", \"r\")) {<CR>uint8_t buf[1024];<CR>while(size_t len = fread(buf, 1, sizeof(buf), fp))<CR>v.insert(v.end(), buf, buf + len);<CR>fclose(fp);<CR>}<CR>".st.et.""
exec "Snippet beginend ".st."v".et.".begin(), ".st."v".et.".end()".st.et.""
exec "Snippet once #ifndef _".st."file:substitute(expand('%'),'\\.\\)','\\u\\1','g')".et."_<CR>#define _".st."file:substitute(expand('%'),'\\(.\\)','\\u\\1','g')".et."_<CR><CR>".st.et."<CR><CR>#endif /* _".st."file:substitute(expand('%'),'\\(.\\)','\\u\\1','g')".et."_ */<CR>".st.et.""
"exec "Snippet class class ".st."name".et." {<CR>public:<CR>".st."name".et." (".st."arguments".et.");<CR>virtual ~".st."name".et."();<CR><CR>private:<CR>".st.":D('/* data */')".et."<CR>};<CR>".st.et.""
exec "Snippet class class ".st."name".et."{<CR>public:<CR>".st."name".et."();<CR>virtual ~".st."name".et."();<CR><CR>private:<CR>".st.":D('/* data */')".et."<CR>};<CR>".st.et.""
" TODO This is a good one but I can't quite work out the syntax yet
exec "Snippet printf printf(\"".st."\"%s\"".et."\\n\"".st."\"%s\":CArgList(Count(@z, '%[^%]'))".et.");<CR>".st.et.""
exec "Snippet vec std::vector<".st."char".et."> v".st.et.";<CR>".st.et.""
exec "Snippet struct struct ".st."name".et." {<CR>".st.":D('/* data */')".et."<CR>};<CR>".st.et.""
exec "Snippet template template <typename ".st."".et."><CR>".st.et.""
" TODO this one as well. Wish I knew more C
" Snippet namespace namespace ${1:${TM_FILENAME/(.*?)\\..*/\\L$1/}}\n{\n\t$0\n};<CR>.st.et
exec "Snippet namespace namespace ".st.":substitute(expand('%'),'.','\\l&', 'g')".et." {<CR>".st.et."<CR>};<CR>".st.et.""
exec "Snippet map std::map<".st."key".et.", ".st."value".et."> map".st.et.";<CR>".st.et.""
"exec "Snippet mark #if 0<CR><CR>".st.":D('#pragma mark -<CR><CR>'}#pragma mark ".st.et."<CR><CR>#endif<CR><CR>".st.et.""
exec "Snippet mark #if 0<CR><CR>".st.et."<CR><CR>#endif<CR><CR>"
exec "Snippet if if (".st.et.") {<CR>".st.et."<CR>}<CR>".st.et.""
exec "Snippet main int main (int argc, char *argv[])<CR>{<CR>".st.et."<CR>}<CR>"
exec "Snippet Inc #include <".st.":D('.h')".et."><CR>".st.et.""
exec "Snippet inc #include \"".st.et.".h\"<CR>".st.et.""
exec "Snippet for for (".st.":D('unsigned int')".et." ".st."i".et." = ".st.":D('0')".et."; ".st."i".et." < ".st."count".et."; ".st."i".et." += ".st.":D('1')".et.") {<CR>".st.et."<CR>}<CR>"

exec "Snippet allocm int **calloc_int_matrix(int rows, int columns) <CR>{<CR>int i;<CR>int **matrix;<CR><CR>matrix = calloc(rows, sizeof(int *));<CR>assert(matrix != NULL);<CR><CR>*matrix = calloc(rows * columns, sizeof(int));<CR>assert(*matrix != NULL);<CR><CR>for (i = 1; i < rows; i += 1)<CR> matrix[i] = matrix[i - 1] + columns;<CR><CR> return matrix;<CR>}<CR><CR>".st.et

exec "Snippet freem void free_int_matrix(int **matrix)<CR>{<CR>free(*matrix);<CR>free(matrix);<CR><CR>return;<CR>}<CR><CR>".st.et
