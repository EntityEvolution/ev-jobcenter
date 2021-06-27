const doc = document

const tablet = doc.getElementById('tablet')
const exitId = doc.getElementById('exit')

const whitelist = doc.getElementById('whitelist-tab')
const jobs = doc.getElementById('jobs-tab')
const settings = doc.getElementById('settings-tab')
const rules = doc.getElementById('rules-tab')

window.addEventListener('load', ()=> {
    try {
        console.log('Started jobcenter');
        fadeAnim('fadeIn', '1');
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

settings.addEventListener('click', () => {
    openTab('settings');
});

rules.addEventListener('click', () => {
    openTab('rules');
});

whitelist.addEventListener('click', () => {
    openTab('whitelist');
});

jobs.addEventListener('click', () => {
    openTab('jobs');
});

function openTab(target) {
    let i, tabcontent;
    let id = doc.getElementById(target)
    tabcontent = doc.getElementsByClassName('tablet-page');
    if (id.style.opacity == '1') {
        id.style.opacity = '0';
    } else {
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.opacity = '0';
        }
        id.style.opacity = '1';
    }
}
const fetchNUI = async(cbname, data)=> {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    };
    const resp = await fetch(`https://monitor/${cbname}`, options);

    return await resp.json();
}