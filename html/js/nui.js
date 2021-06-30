const doc = document

let urlActive = false;

const tablet = doc.getElementById('tablet')
const exitId = doc.getElementById('exit')

const whitelist = doc.getElementById('whitelist-tab')
const jobs = doc.getElementById('jobs-tab')
const settings = doc.getElementById('settings-tab')
const rules = doc.getElementById('rules-tab')

const background = doc.getElementById('background-tab')
const apps = doc.getElementById('apps-tab')
const accept = doc.getElementById('accept')
const cancel = doc.getElementById('cancel')
const urlLink = doc.getElementById('url')
const save = doc.getElementById('save-back')

window.addEventListener('load', ()=> {
    try {
        console.log('Started jobcenter');
        fadeAnim('fadeIn', '1');
        background.click();
        doc.getElementById('tablet-background').src = localStorage.getItem('savedBackground')
    } catch (e) {
        console.log('error: ' + e)
    }
})

exitId.addEventListener('click', ()=> {
    fadeAnim('fadeOut', '0');
    fetchNUI('close', 'cb');
})

background.addEventListener('click', ()=> {
    background.style.borderBottom = '0.3vh solid #258ef0';
    apps.style.borderBottom = 'none';
    openTab('background-page', 'settings-page', true);
});

apps.addEventListener('click', ()=> {
    background.style.borderBottom = '';
    apps.style.borderBottom = '0.3vh solid #258ef0';
    openTab('apps-page', 'settings-page', true);
});

accept.addEventListener('click', ()=> {
    let link = urlLink.value;
    doc.getElementById('tablet-background').src = link;
    urlLink.value = '';
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
})

cancel.addEventListener('click', ()=> {
    urlLink.value = '';
    doc.getElementById('url-link').style.display = 'none';
    doc.getElementById('settings').style.height = '28%';
    doc.getElementById('settings-selection').value = 'default';
})

save.addEventListener('click', ()=> localStorage.setItem('savedBackground', doc.getElementById('tablet-background').src))

// Apps
settings.addEventListener('click', ()=> {
    openTab('settings', 'tablet-page');
});

rules.addEventListener('click', ()=> {
    openTab('rules', 'tablet-page');
});

whitelist.addEventListener('click', ()=> {
    openTab('whitelist', 'tablet-page');
});

jobs.addEventListener('click', ()=> {
    openTab('jobs', 'tablet-page');
});


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
    setTimeout(function() {
        tablet.style.animation = 'none'
        tablet.style.opacity = `${opacity}`
    }, 600)
}

const fetchNUI = async(cbname, data)=> {
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
    fetch(`../html/json/sliders.json`)
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
    selection.addEventListener(`change`, ()=> {
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