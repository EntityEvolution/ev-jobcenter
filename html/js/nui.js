const doc = document

const tablet = doc.getElementById('tablet')
const exitId = doc.getElementById('exit')

const whitelist = doc.getElementById('whitelist-tab')
const jobs = doc.getElementById('jobs-tab')
const settings = doc.getElementById('settings-tab')
const rules = doc.getElementById('rules-tab')
const bugs = doc.getElementById('bugs-tab')

const background = doc.getElementById('background-tab')
const apps = doc.getElementById('apps-tab')
const accept = doc.getElementById('accept')
const cancel = doc.getElementById('cancel')
const urlLink = doc.getElementById('url')
const save = doc.getElementById('save-back')

const admin = doc.getElementById('admin-btn')
const bquest = doc.getElementById('bugs-question')
const submit = doc.getElementById('bugs-submit')

let urlActive = false;

let actWhitelist = false;
let actJobs = false;
let actRules = false;
let actBugs = true;

window.addEventListener('load', () => {
    try {
        console.log('Started jobcenter');
        fadeAnim('fadeIn', '1');
        apps.click();
        bugs.click();
        // Restore old tablet background //doc.getElementById('tablet-background').src = localStorage.getItem('savedBackground')
    } catch (e) {
        console.log('error: ' + e)
    }
})

// Background tab
exitId.addEventListener('click', () => {
    fadeAnim('fadeOut', '0');
    fetchNUI('close', 'cb');
})

background.addEventListener('click', () => {
    background.style.borderBottom = '0.3vh solid #258ef0';
    apps.style.borderBottom = 'none';
    openTab('background-page', 'settings-page', true);
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
});

apps.addEventListener('click', () => {
    background.style.borderBottom = '';
    apps.style.borderBottom = '0.3vh solid #258ef0';
    openTab('apps-page', 'settings-page', true);
    doc.getElementById('url-link').style.display = 'block'
    doc.getElementById('settings').style.height = '40%'
});

accept.addEventListener('click', () => {
    let link = urlLink.value;
    doc.getElementById('tablet-background').src = link;
    urlLink.value = '';
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
})

cancel.addEventListener('click', () => {
    urlLink.value = '';
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
})

save.addEventListener('click', () => localStorage.setItem('savedBackground', doc.getElementById('tablet-background').src))

// Apps tab
doc.getElementById('whitelist-apps').addEventListener('click', () => {
    if (!actWhitelist) {
        whitelist.style.display = 'none';
        actWhitelist = true;
    } else {
        whitelist.style.display = 'flex';
        actWhitelist = false;
    }
});

doc.getElementById('jobs-apps').addEventListener('click', () => {
    if (!actJobs) {
        jobs.style.display = 'none';
        actJobs = true;
    } else {
        jobs.style.display = 'flex';
        actJobs = false;
    }
});

doc.getElementById('rules-apps').addEventListener('click', () => {
    if (!actRules) {
        rules.style.display = 'none';
        actRules = true;
    } else {
        rules.style.display = 'flex';
        actRules = false;
    }
});

doc.getElementById('bugs-apps').addEventListener('click', () => {
    if (!actBugs) {
        bugs.style.display = 'none';
        actBugs = true;
    } else {
        bugs.style.display = 'flex';
        actBugs = false;
    }
});

// Bugs tab
admin.addEventListener('click', () => {
    bquest.style.display='block';
    setTimeout(function() {
        bquest.style.opacity='1';
    }, 100)
})

doc.getElementById('bugs-accept').addEventListener('click', ()=> {
    bquest.style.opacity='0';
    fetchNUI('sendAdminMessage', 'cb')
    setTimeout(function() {
        bquest.style.opacity='none';
    }, 600)
})

doc.getElementById('bugs-cancel').addEventListener('click', () => {
    bquest.style.opacity = '0';
    setTimeout(function() {
        bquest.style.display='none';
    }, 600)
})

submit.addEventListener('click', ()=> {
    const cls = doc.getElementsByClassName('inp');
    let subject = doc.getElementById('data-subject').value;
    let data = [];
    for (let i = 0; i < cls.length; i++) {
        data.push(cls[i].value)
    }
    console.log(subject)
    fetchNUI('getFormData', {subject: subject, discord: data[0], issue: data[1], description: data[2]})
})

// Apps
settings.addEventListener('click', () => openTab('settings', 'tablet-page'));

rules.addEventListener('click', () => openTab('rules', 'tablet-page'));

whitelist.addEventListener('click', () => openTab('whitelist', 'tablet-page'));

jobs.addEventListener('click', () => openTab('jobs', 'tablet-page'));

bugs.addEventListener('click', () => openTab('bugs', 'tablet-page'));

function openTab(target, className, settings) {
    let i, tabcontent;
    let id = doc.getElementById(target)
    tabcontent = doc.getElementsByClassName(className);
    if (settings) {
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.opacity = '0';
        }
        id.style.opacity = '1';
    } else {
        if (id.style.opacity == '1') {
            id.style.opacity = '0';
        } else {
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.opacity = '0';
            }
            id.style.opacity = '1';
        }
    }
}

function fadeAnim(anim, opacity) {
    tablet.style.animation = `${anim} 1s forwards`;
    setTimeout(function () {
        tablet.style.animation = 'none'
        tablet.style.opacity = `${opacity}`
    }, 600)
}

const fetchNUI = async (cbname, data) => {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    };
    const resp = await fetch(`https://ev-jobcenter-esx/${cbname}`, options);
    return await resp.json();
}

window.addEventListener(`DOMContentLoaded`, () => {
    fetch(`../html/json/backgrounds.json`)
        .then((response) => response.json())
        .then((data) => {
            createOptions(data);
        })
        .catch((error) => {
            console.error('Error: ' + error);
        });
})

function createOptions(data) {
    const selection = doc.getElementById('settings-selection');
    const tabletBack = doc.getElementById('tablet-background')
    selection.addEventListener(`change`, () => {
        if (selection.value == 'url') {
            urlActive = true;
            doc.getElementById('url-link').style.display = 'block'
            doc.getElementById('settings').style.height = '48%'
        } else {
            if (urlActive) {
                urlActive = false;
                doc.getElementById('url-link').style.display = 'none'
                doc.getElementById('settings').style.height = '28%'
            }
            tabletBack.src = selection.value
        }
    });
    data.forEach(dataItem => {
        const option = doc.createElement('option');
        option.text = dataItem.title;
        option.value = dataItem.background
        selection.add(option);
    });
}