window.addEventListener('message', (e) => {
    switch (e.data.action) {
        case 'show':
            tablet.style.animation
            break;
    }
})

// Hide when escape is pressed
doc.onkeyup = (event) => {
    if (event.key == 'Escape') {
        $.post('https://ev-jobcenter-esx/close');
    }
}