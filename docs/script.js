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

