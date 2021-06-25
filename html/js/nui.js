const doc = document

const exitId = doc.getElementById('exit')

window.addEventListener('load', ()=> {
    try {
        console.log('Started jobcenter')
    } catch (e) {
        console.log('error: ' + e)
    }
})

exitId.addEventListener('click', ()=> {
    console.log('a')
})