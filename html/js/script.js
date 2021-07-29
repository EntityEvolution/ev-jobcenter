window.addEventListener('message', (e) => {
    switch (e.data.action) {
        case 'open':
            fadeAnim('fadeIn', '1');
            break;

        case 'time':
            doc.getElementById('tablet-time').innerHTML = e.data.time;
            doc.getElementById('tablet-day').innerHTML = e.data.day;
            doc.getElementById('tablet-day-text').innerHTML = e.data.dayText;
            doc.getElementById('tablet-month').innerHTML = e.data.month;
            break;

        case 'restoreData':
            if (null != localStorage.getItem('savedBackground')) {
                doc.getElementById('tablet-background').src = localStorage.getItem('savedBackground')
            }
            fetchSliders();
            break;
    }
})

// Hide when escape is pressed
doc.onkeyup = (event) => {
    if (event.key == 'Escape') {
        fadeAnim('fadeOut', '0');
        fetchNUI('close', 'cb');
    }
}