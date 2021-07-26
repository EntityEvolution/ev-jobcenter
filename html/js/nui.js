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
const wquest = doc.getElementById('whitelist-question')
const submit = doc.getElementById('bugs-submit')

const dropdown = doc.getElementsByClassName("dropdown-btn");

let urlActive = false;
let notiActive = false

let actWhitelist = false;
let actJobs = false;
let actRules = false;
let actBugs = true;

window.addEventListener('load', () => {
    try {
        if (Config.devMode) {
            console.log('Started jobcenter');
            fadeAnim('fadeIn', '1');
            doc.getElementById('tablet-background').src = localStorage.getItem('savedBackground');
            whitelist.click();
        }
        apps.click();
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
    progressNoti(Config.AppliedBackground, Config.AppliedBackgroundTime);
})

cancel.addEventListener('click', () => {
    urlLink.value = '';
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
})

save.addEventListener('click', () => {
    localStorage.setItem('savedBackground', doc.getElementById('tablet-background').src);
    progressNoti(Config.SavedBackground, Config.SavedBackgroundTime)
})

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
    progressNoti(Config.AdminMessage, Config.AdminMessageTime)
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
        if (!cls[i].value) {
            progressNoti(Config.SubmitData, Config.SubmitDataTime)
            return
        } else {
            data.push(cls[i].value)
        }
    }
    fetchNUI('getDataForm', {subject: subject, discord: data[0], issue: data[1], description: data[2]})
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
window.addEventListener('load', () => {
    for (let i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener('click', function() {
            this.classList.toggle('active');
            const dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === 'block') {
                dropdownContent.style.display='none';
            } else {
                dropdownContent.style.display='block';
            }
        });
    }
})

function fadeAnim(anim, opacity) {
    tablet.style.animation = `${anim} 1s forwards`;
    setTimeout(function () {
        tablet.style.animation = 'none'
        tablet.style.opacity = `${opacity}`
    }, 600)
}

function progressNoti(message, sec) {
    let i = 0;
    const text = doc.getElementById('noti-text')
    const container = doc.getElementById('tablet-notification')
    const progress = doc.getElementById('progress-noti');
    if (i == 0) {
        text.textContent = '\xa0\xa0' + message
        if (sec === undefined && i == 0) {
            sec = Config.defaultTime
        }
        i = 1;
        const fadeNoti = (anim, opacity) => {
            container.style.animation = `${anim} 0.7s forwards`;
            setTimeout(function () {
                container.style.animation = 'none'
                container.style.opacity = `${opacity}`
            }, 600)
        }
        if (!notiActive) {
            fadeNoti('fadeIn', 1)
            let curWidth = 100.0;
            let id = setInterval(frame, sec * 5);
            function frame() {
                if (curWidth <= 0) {
                    if (notiActive) {
                        notiActive = false
                    }
                    clearInterval(id);
                    i = 0;
                    curWidth = 100.0
                    fadeNoti('fadeOut', 0)
                    return
                } else {
                    if (!notiActive) {
                        notiActive = true
                    }
                    curWidth -= 0.5;
                    progress.style.width = curWidth + "%";
                }
            }
        } else {
            console.log('Currently Active')
        }
    }
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

function wQuestion(data) {
    const acp = doc.getElementById('whitelist-accept');
    const can = doc.getElementById('whitelist-cancel');

    if (acp.getAttribute('listener') !== 'true') {
        doc.getElementById('whitelist-accept').addEventListener('click', (e)=> {
            const elementClicked = e.target;
            elementClicked.setAttribute('listener', 'true');
            const q = doc.getElementById('whitelist-val').value
            if (!q) {
                progressNoti(Config.WhitelistNoMessage, Config.WhitelistNoMessageTime)
            } else {
                progressNoti(Config.WhitelistMessage, Config.WhitelistMessageTime)
                wquest.style.opacity = '0';
                setTimeout(function() {
                    wquest.style.display='none';
                }, 600)
                fetchNUI('sendFormData', {whitelisted: data.whitelist, job: data.job, grade: data.grade, title: data.imageTitle, message: q})
            }
        })
    }

    if (can.getAttribute('listener') !== 'true') {
        can.addEventListener('click', (e)=> {
            const elementClicked = e.target;
            elementClicked.setAttribute('listener', 'true');
            wquest.style.opacity = '0';
            setTimeout(function() {
                wquest.style.display='none';
            }, 600)
        })
    }
}

window.addEventListener(`DOMContentLoaded`, () => {
    fetch(`../json/backgrounds.json`)
        .then((response) => response.json())
        .then((data) => {
            createOptions(data);
        })
        .catch((error) => {
            console.error('Error: ' + error);
        });
    fetch(`../json/jobs.json`)
        .then((response) => response.json())
        .then((data) => {
            createJobs(data);
        })
        .catch((error) => {
            console.error('Error: ' + error);
        });
})

function createJobs(data) {
    const cont = doc.getElementById('jobs-container');
    const contWhitelist = doc.getElementById('whitelist-container');
    data.forEach(dataItem => {
        const divMain = doc.createElement('div');
        const divImage = doc.createElement('div');
        const imageJob = doc.createElement('img');
        const imageTitle = doc.createElement('span');
        const divLocation = doc.createElement('div');
        const locationTitle = doc.createElement('span');
        const locationText = doc.createElement('span');
        const divDesc = doc.createElement('div');
        const descTitle = doc.createElement('span');
        const descText = doc.createElement('span');
        const divBtn = doc.createElement('div');
        const btn = doc.createElement('button');

        divMain.classList.add('job-slide-container');
        divImage.classList.add('slide-image-container');
        imageJob.classList.add('slide-image');
        imageTitle.classList.add('image-title');
        divLocation.classList.add('slide-location-container');
        locationTitle.classList.add('def-title');
        locationText.classList.add('def-text', 'loc');
        divDesc.classList.add('slide-desc-container');
        descTitle.classList.add('def-title');
        descText.classList.add('def-text');
        divBtn.classList.add('slide-btn-container');
        btn.classList.add('jobs-btn');

        imageJob.src = dataItem.imageJob;
        imageJob.setAttribute("loading", "lazy")
        imageJob.alt = 'Job image'
        imageTitle.innerHTML = dataItem.imageTitle;
        locationTitle.innerHTML = dataItem.locationTitle;
        locationText.innerHTML = dataItem.locationDescription;
        descTitle.innerHTML = dataItem.descTitle;
        descText.innerHTML = dataItem.descDescription;
        btn.innerHTML = dataItem.buttonText;
        btn.id = dataItem.job;

        locationText.addEventListener('click', () => {
            fetchNUI('getDataLocation', dataItem.locationCoords),
            progressNoti(dataItem.locationNotification, Config.LocationTime);
        });

        divBtn.appendChild(btn);
        divDesc.appendChild(descTitle);
        divDesc.appendChild(descText);
        divLocation.appendChild(locationTitle);
        divLocation.appendChild(locationText);

        divImage.appendChild(imageJob);
        divImage.appendChild(imageTitle);

        divMain.appendChild(divImage);
        divMain.appendChild(divLocation);
        divMain.appendChild(divDesc);
        divMain.appendChild(divBtn);
        if (JSON.parse(dataItem.whitelist)) {
            btn.addEventListener('click', () => {
                wquest.style.display='block';
                setTimeout(function() {
                    wquest.style.opacity='1';
                }, 100)
                wQuestion(dataItem);
            });

            contWhitelist.appendChild(divMain);
        } else {
            btn.addEventListener('click', () => {
                fetchNUI('setDataJob', {whitelisted: dataItem.whitelist, job: dataItem.job, grade: dataItem.grade}),
                progressNoti(dataItem.buttonNotification, Config.JobTime);
            });

            cont.appendChild(divMain);
        }
    });
}

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