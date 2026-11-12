# Why the shell starts fast

Measured on an M-series MacBook, zsh 5.9, Homebrew in `/opt/homebrew`.

```
hyperfine --warmup 3 --runs 15 'zsh -i -c exit', same machine, same cache:
  compinit before p10k (old order):  66.7 ms  ± 0.9
  p10k before compinit (this repo):  67.0 ms  ± 1.1
```

Total wall time is the sum of zsh's own startup (~5 ms), parsing the rc files,
and the work below. The reorder does not change total wall time — it changes
*when* the prompt appears (see the next section). Function-level timings come
from `zprof`:

| Stage | What it does | Time |
|---|---|---|
| `compinit` | loads `~/.cache/zsh/.zcompdump`, security check once per 24 h | 15.0 ms |
| p10k theme init | gitstatus setup, mode detection, `_p9k_init_ssh` (`who -m` fork) | 16.1 ms |
| `zsh-syntax-highlighting` | loads highlighter functions | 6.0 ms |
| `zsh-autosuggestions` | one hook | 0.2 ms |
| everything else | options, aliases, functions, zstyles, LS_COLORS source | ~2 ms |

That is ~39 ms of instrumented work; the rest is process spawn, rc parsing and
the p10k prompt setup.

## What "instant prompt" means here

Powerlevel10k caches the last prompt in
`~/.cache/p10k-instant-prompt-*.zsh` and prints it before the rest of the rc
files run. For that to work the theme must be sourced **before** anything slow.

This setup used to source `compinit` first (`.zshrc` line 8) and the p10k theme
after it (line 17), so the cached prompt appeared only after `compinit` had
finished — ~17 ms of blank screen on every new terminal. Now the order is:

```
instant prompt -> options -> plugin paths -> setup.local.zsh -> p10k theme
-> p10k config -> compinit -> aliases -> plugins
```

The prompt is on screen after the ~2 ms it takes p10k to initialise, and the
15 ms of `compinit` happens in the background where the user cannot see it.
Wall-clock startup does not change; the time until the prompt reacts does.

## Other things that keep it lean

* **No Oh My Zsh.** Each piece is loaded directly: p10k, autosuggestions,
  syntax-highlighting, history-substring-search, completions.
* **Lazy zoxide.** `zoxide init zsh` forks a subprocess; here it runs on the
  first `cd`/`z`/`zi` instead of on every shell start.
* **`compinit` with a daily check.** `compinit -C` (no security scan) on normal
  starts, a full `compinit` once the dump is older than 24 h.
* **Cached `LS_COLORS`.** `gdircolors -b` is written to
  `~/.cache/zsh/LS_COLORS.zsh` and re-sourced; regenerated weekly at most.
* **No duplicate widgets.** The `up-line-or-beginning-search` bindings in
  `.zsh_completions_conf` were dead weight: `history-substring-search` bound
  the same arrows later in `.zshrc` and won. Removed.
* **No `command -v` soup at startup** — one `if` per optional tool, and the
  tunnel aliases simply do not get created when `setup.local.zsh` is absent.

## Where the remaining time goes

If you want to go below ~70 ms, the two real targets are:

1. `compinit` — `zcompile ~/.cache/zsh/.zcompdump` (measured: 23.5 ms -> 17.5 ms
   for the load, ~6 ms saved). Costs one extra file to keep in sync.
2. `_p9k_init_ssh` — p10k shells out to `who -m` to detect SSH sessions,
   ~10 ms. It is inside the vendored plugin; patching it is not worth it.

Nothing else in the profile is above 1 ms.
