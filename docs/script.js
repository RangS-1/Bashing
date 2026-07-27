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
