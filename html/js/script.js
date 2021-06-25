doc.onkeyup = (event) => {
    if (event.key == 'Escape') {
        $.post('https://ev-jobcenter-esx/close');
    }
}