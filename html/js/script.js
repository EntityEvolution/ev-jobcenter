window.addEventListener('message', (e) => {
    switch (e.data.action) {
        case 'open':
            fadeAnim('fadeIn', '1');
            break;

        case 'time':
            doc.getElementById('tablet-time').innerHTML = e.data.time
            break;
    }
})

// Hide when escape is pressed
doc.onkeyup = (event) => {
    if (event.key == 'Escape') {
        fadeAnim('fadeOut', '0')
        $.post('https://ev-jobcenter-esx/close');
    }
}