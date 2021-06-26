const doc = document

const tablet = doc.getElementById('tablet')
const exitId = doc.getElementById('exit')

window.addEventListener('load', ()=> {
    try {
        console.log('Started jobcenter');
    } catch (e) {
        console.log('error: ' + e)
    }
})

exitId.addEventListener('click', ()=> {
    fadeAnim('fadeOut', '0')
    $.post('https://ev-jobcenter-esx/close')
})

function fadeAnim(anim, opacity) {
    tablet.style.animation = `${anim} 1s forwards`;
    setTimeout(function() {
        tablet.style.animation = 'none'
        tablet.style.opacity = `${opacity}`
    }, 600)
}