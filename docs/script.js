document.addEventListener("DOMContentLoaded", () => {
    // Typewriter effect for the main subtitle
    const subtitleElement = document.getElementById("typewriter-subtitle");
    const originalText = "Bash Script project by RangS";
    
    // Clear initial content
    subtitleElement.innerHTML = "";
    
    let index = 0;
    const speed = 70; // speed in milliseconds per character
    
    function typeWriter() {
        if (index < originalText.length) {
            subtitleElement.textContent += originalText.charAt(index);
            index++;
            setTimeout(typeWriter, speed);
        } else {
            // Add a blinking cursor span after typing completes
            const cursor = document.createElement("span");
            cursor.className = "terminal-cursor";
            cursor.textContent = "▋";
            cursor.style.color = "var(--color-accent-green)";
            cursor.style.marginLeft = "4px";
            cursor.style.animation = "blink 1s step-end infinite";
            subtitleElement.appendChild(cursor);
        }
    }
    
    // Start the typing animation after 500ms
    setTimeout(typeWriter, 500);

    // Print developer console greeting
    console.log(
        "%c ⚡ BASH-SCRIPTING PORTFOLIO BY RANGS ⚡ %c\n\nWelcome to the developer console! Feel free to modify the source code under docs/ to customize your scripts portfolio.\n\nColorScheme: Black & Green\nYear: 2026",
        "background: #111216; color: #00ff66; padding: 6px 12px; border-radius: 4px; border: 1px solid #005a26; font-family: monospace; font-size: 12px; font-weight: bold;",
        "color: #8b949e; font-family: monospace; font-size: 11px;"
    );
});

// Dynamic hover effect for buttons (Optional console logger for interactions)
const buttons = document.querySelectorAll(".github-btn");
buttons.forEach(button => {
    button.addEventListener("click", (e) => {
        const id = button.id;
        console.log(`%c[Redirect]%c Redirecting user to Github repository from ${id}`, "color: #00ff66; font-weight: bold;", "color: inherit;");
    });
});

// Terminal Modal Controls
const installBtn = document.getElementById("install-guide-btn");
const installModal = document.getElementById("install-modal");
const closeDotBtn = document.getElementById("modal-close-dot");
const closeXBtn = document.getElementById("modal-close-x");
const copyQuickBtn = document.getElementById("copy-quick-btn");
const quickCodeElement = document.getElementById("quick-install-code");

if (installBtn && installModal) {
    // Open Modal
    installBtn.addEventListener("click", () => {
        if (typeof installModal.showModal === "function") {
            installModal.showModal();
        } else {
            installModal.setAttribute("open", "");
        }
    });

    // Close Modal helper
    const closeModal = () => {
        if (typeof installModal.close === "function") {
            installModal.close();
        } else {
            installModal.removeAttribute("open");
        }
    };

    if (closeDotBtn) closeDotBtn.addEventListener("click", closeModal);
    if (closeXBtn) closeXBtn.addEventListener("click", closeModal);

    // Fallback backdrop light-dismiss for browsers without native closedby support
    installModal.addEventListener("click", (event) => {
        if (event.target === installModal) {
            closeModal();
        }
    });

    // Copy to Clipboard Action
    if (copyQuickBtn && quickCodeElement) {
        copyQuickBtn.addEventListener("click", async () => {
            const textToCopy = quickCodeElement.textContent;
            try {
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    await navigator.clipboard.writeText(textToCopy);
                } else {
                    // Fallback for older clipboard API
                    const textarea = document.createElement("textarea");
                    textarea.value = textToCopy;
                    document.body.appendChild(textarea);
                    textarea.select();
                    document.execCommand("copy");
                    document.body.removeChild(textarea);
                }

                copyQuickBtn.classList.add("copied");
                const copyTextSpan = copyQuickBtn.querySelector(".copy-text");
                if (copyTextSpan) copyTextSpan.textContent = "Copied!";

                setTimeout(() => {
                    copyQuickBtn.classList.remove("copied");
                    if (copyTextSpan) copyTextSpan.textContent = "Copy";
                }, 2000);
            } catch (err) {
                console.error("Failed to copy text: ", err);
            }
        });
    }
}

/* ==========================================================================
   Search & Filter Engine Logic
   ========================================================================== */
document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById("script-search");
    const clearBtn = document.getElementById("search-clear-btn");
    const filterPills = document.querySelectorAll(".filter-pill");
    const scriptCards = document.querySelectorAll(".script-card");
    const visibleCountEl = document.getElementById("visible-count");
    const noResultsCard = document.getElementById("no-results-state");
    const noResultsCmd = document.getElementById("no-results-cmd");
    const searchQueryDisplay = document.getElementById("search-query-display");
    const tipTags = document.querySelectorAll(".tip-tag");

    const countAllEl = document.getElementById("count-all");
    const countSudoEl = document.getElementById("count-sudo");
    const countUserEl = document.getElementById("count-user");

    let currentFilter = "all";
    let searchQuery = "";

    // Calculate pill category totals dynamically
    function updateCounts() {
        let totalAll = scriptCards.length;
        let totalSudo = 0;
        let totalUser = 0;

        scriptCards.forEach(card => {
            const isSudo = card.getAttribute("data-sudo") === "true";
            if (isSudo) {
                totalSudo++;
            } else {
                totalUser++;
            }
        });

        if (countAllEl) countAllEl.textContent = totalAll;
        if (countSudoEl) countSudoEl.textContent = totalSudo;
        if (countUserEl) countUserEl.textContent = totalUser;
    }

    updateCounts();

    // Core Filtering Logic
    function applyFilter() {
        searchQuery = searchInput ? searchInput.value.trim().toLowerCase() : "";

        // Toggle clear search button visibility
        if (clearBtn) {
            if (searchQuery.length > 0) {
                clearBtn.classList.remove("hidden");
            } else {
                clearBtn.classList.add("hidden");
            }
        }

        let visibleCount = 0;

        scriptCards.forEach(card => {
            const name = (card.getAttribute("data-name") || "").toLowerCase();
            const isSudo = card.getAttribute("data-sudo") === "true";
            const keywords = (card.getAttribute("data-keywords") || "").toLowerCase();
            const desc = (card.querySelector(".script-desc")?.textContent || "").toLowerCase();

            // Category match check
            let matchesCategory = true;
            if (currentFilter === "sudo") {
                matchesCategory = isSudo;
            } else if (currentFilter === "user") {
                matchesCategory = !isSudo;
            }

            // Search query match check
            let matchesSearch = true;
            if (searchQuery.length > 0) {
                const searchTerms = searchQuery.split(/\s+/);
                matchesSearch = searchTerms.every(term => {
                    if (term === "sudo") return isSudo || name.includes("sudo") || desc.includes("sudo") || keywords.includes("sudo");
                    if (term === "user") return !isSudo || name.includes("user") || desc.includes("user") || keywords.includes("user");
                    return name.includes(term) || desc.includes(term) || keywords.includes(term);
                });
            }

            if (matchesCategory && matchesSearch) {
                card.classList.remove("filtered-out");
                visibleCount++;
            } else {
                card.classList.add("filtered-out");
            }
        });

        // Update counter
        if (visibleCountEl) visibleCountEl.textContent = visibleCount;

        // Show/Hide Empty State
        if (noResultsCard) {
            if (visibleCount === 0) {
                noResultsCard.classList.remove("hidden");
                const queryText = searchQuery || currentFilter;
                if (searchQueryDisplay) searchQueryDisplay.textContent = queryText;
                if (noResultsCmd) noResultsCmd.textContent = `grep "${queryText}" ./scripts/`;
            } else {
                noResultsCard.classList.add("hidden");
            }
        }
    }

    // Input Search Listener
    if (searchInput) {
        searchInput.addEventListener("input", applyFilter);
    }

    // Clear Button Listener
    if (clearBtn) {
        clearBtn.addEventListener("click", () => {
            if (searchInput) {
                searchInput.value = "";
                searchInput.focus();
            }
            applyFilter();
        });
    }

    // Filter Pills Listener
    filterPills.forEach(pill => {
        pill.addEventListener("click", () => {
            filterPills.forEach(p => p.classList.remove("active"));
            pill.classList.add("active");
            currentFilter = pill.getAttribute("data-filter") || "all";
            applyFilter();
        });
    });

    // Tip Tags (Quick search recommendation click)
    tipTags.forEach(tag => {
        tag.addEventListener("click", () => {
            const tagValue = tag.getAttribute("data-tag") || tag.textContent.trim();
            if (searchInput) {
                searchInput.value = tagValue;
                searchInput.focus();
            }
            // Switch filter pill back to all for broad search
            filterPills.forEach(p => p.classList.remove("active"));
            const allPill = document.querySelector('.filter-pill[data-filter="all"]');
            if (allPill) allPill.classList.add("active");
            currentFilter = "all";
            applyFilter();
        });
    });

    // Keyboard Shortcut: press '/' to focus search input, 'Esc' to clear focus
    document.addEventListener("keydown", (e) => {
        if (e.key === "/" && document.activeElement !== searchInput) {
            // Prevent typing '/' into active inputs or textareas
            if (["INPUT", "TEXTAREA"].includes(document.activeElement.tagName)) return;
            e.preventDefault();
            if (searchInput) searchInput.focus();
        } else if (e.key === "Escape" && document.activeElement === searchInput) {
            searchInput.value = "";
            searchInput.blur();
            applyFilter();
        }
    });
});


