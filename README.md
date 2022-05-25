# sinatra-cookbook

## A first attempt at MVC model web app
As part of the le Wagon bootcamp, we are currently learning MVC model in the console. However, that's never enough for me so I have gone the extra mile
and built the model using the sinatra app. 

## steps to run this as a local app
1. copy repository & pull files down into your preferred coding tool
2. run 'rackup config.ru' to start the sinatra loop
3. copy the relevant path indicated in your terminal (eg. localhost:4567) to a web browser and enjoy!

## steps to run this on ngrok for others to access
1. install ngrok
2. run ```ngrok http 4567```
3. copy the relevant http://.....ngrok.io path indicated in your terminal to a web browser and share! 
Note this only works when it's running on your local terminal

## app functions
1. **List** recipes which have been created or imported from the web, along with their status (i.e. whether or not I have actually tried cooking them)
2. **Create** recipes using a form
3. **Import** recipes from allrecipes.com (web scraping with nokogiri)
4. **Delete** recipes 
5. **Change** recipe status (marking them as 'done' or not)
