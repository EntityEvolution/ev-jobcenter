const doc = document

const tablet = doc.getElementById('tablet')
const exitId = doc.getElementById('exit')

window.addEventListener('load', ()=> {
    try {
        console.log('Started jobcenter');
        tablet.style.animation = 'fadeIn 0.5s forwards';
        setTimeout(function() {
            tablet.style.animation = 'none'
            tablet.style.opacity = '1'
        }, 600)
    } catch (e) {
        console.log('error: ' + e)
    }
})

exitId.addEventListener('click', ()=> {
    tablet.style.animation = 'fadeOut 0.5s forwards';
    setTimeout(function() {
        tablet.style.animation = 'none'
        tablet.style.opacity = '0'
    }, 600)
})

function fadeAnim(anim, opacity) {
    tablet.style.animation = 'fadeOut 0.5s forwards';
    setTimeout(function() {
        tablet.style.animation = 'none'
        tablet.style.opacity = '0'
    }, 600)
}