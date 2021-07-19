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

const dropdown = document.getElementsByClassName("dropdown-btn");
let i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener('click', function() {
    this.classList.toggle('active');
    const dropdownContent = this.nextElementSibling;
	  console.log(dropdownContent)
    if (dropdownContent.style.display === 'block') {
      dropdownContent.style.display='none';
    } else {
      dropdownContent.style.display='block';
    }
  });
}