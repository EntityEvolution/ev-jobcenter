# ev-jobcenter
A simple NUI job center

### [Discord](https://discord.com/invite/u4zk4tVTkG)
### [Donation](https://www.buymeacoffee.com/bombayV)

# License
This project does not contain a license, therefore you are not allowed to add one and claim it as yours. You are not allowed to sell this nor re-distribute it. If you want to modify or make an agreement, you can contact me. Pull requests are accepted as long as they do not contain breaking changes. You can read more [here](https://opensource.stackexchange.com/questions/1720/what-can-i-assume-if-a-publicly-published-project-has-no-license) 

### Requirements
- Framework
- [Polyzone](https://github.com/mkafrin/PolyZone)

### Installation
1) Download from the releases tab.
2) Move the resource into your resources folder.
3) Add `ensure ev-jobcenter` in your server.cfg
4) Start your server.

### Features
- Automatically find your framework (ESX, QB)
- Easy to create jobs with or without whitelist.
- Easy to create backgrounds.
- Rules page.
- Bugs page.
- Settings page.
- Save background.
- Discord webhook.
- Multiple jobcenters.

## Documentation
- Creating New Jobs
1) Go to the JSON/jobs.json
2) Copy a block and paste a block at the bottom.
3) Fix errors with commas and parenthesis.
4) Update all texts to match your new job.
5) Choose if you want whitelisted or not.
6) Restart the resource (better to restart server if there are people in it)

- Creating New Backgrounds
1) Go to the JSON/backgrounds.json
2) Copy a block and paste a block at the bottom.
3) Fix errors with commas and parenthesis.
4) Add your link to the image and the text to display (it can be url or directly from the `./img/nameofimage.png`
5) Restart the resource (better to restart server if there are people in it)

- Creating New Rules
1) Go to html/ui.html
2) Check comments inside file.
3) Good luck lmao (if you need help contact me on discord since that's tedious).

- Deleting an app
1) Go [here](https://github.com/EntityEvolution/ev-jobcenter/blob/main/html/ui.html#L334) and find the app you want (it has to be a button class)
2) Delete the button block
3) Go [here](https://github.com/EntityEvolution/ev-jobcenter/blob/main/html/ui.html#L299) and find the settings you want (it has to be the entire label class)
4) Delete the label block
5) Restart the resource.
