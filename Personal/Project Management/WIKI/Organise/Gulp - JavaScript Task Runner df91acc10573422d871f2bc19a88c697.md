# Gulp - JavaScript Task Runner

<aside>
💡 This template provides context/instructions for the languages you use.

</aside>

# 1. Installation

<aside>
💡 A task runner which is able to perform

</aside>

- Live Reload of a page
- Run a Static Server
- Minify CSS/JS

CLI = Global : Allows commands to be ran in terminal

Local : Dependencies can be rebuilt from rooy using 'npm install'

### Basic Operation

- Install node JS
    - You can go to the website & install from the link ([https://nodejs.org/en/](https://nodejs.org/en/)) or use the command below (if homebrew is installed.)
    
    ```bash
    brew install node
    ```
    
- Install Gulp Globally
    
    ```bash
    sudo npm install gulp@{VERSION} -g
    ```
    
    The version will install a specific version of gulp. After installation, check the correct version has been installed using
    
    ```bash
    gulp -v
    ```
    
    ---
    

Navigate to the root of your project folder & run the command:

```bash
npm init
```

Install the same version in the root of your project.

```bash
npm install gulp@3.9.1
```

Follow prompts

Install gulp locally in dev -dependencies

```bash
npm install gulp --save --dev
```

Create a 'gulpfile.js' wihtin the root of the project folder.

Within 'gulpfile.js' add the following code:

```bash
var gulp = require('gulp');

// This needs to be the same as it appears within package.json
```

### Basic Task Creation

Tasks are ran within the 'gulpfile.js' file.

```bash
gulp.task('xx', function (){
  console.log('Hello World!')
});

// 'xx' is the name of the task which you wish to run.
```

# 2. AutoPrefixer

Autoprefixer parses CSS files and adds vendor prefixes to CSS rules using the Can I Use database to determine which prefixes are needed.

1. Install AutoPrefixer

```bash
npm install gulp-autoprefixer --save-dev
```

2. Full example

```jsx

gulp.task('styles', function (){
    console.log('Starting Styles task');
    return gulp.src(['public/css/reset.css', CSS_PATH])
    .pipe(autoPrefixer({
        browsers: ['last 2 versions', 'ie 8']
    }))
    .pipe(concat('styles.css'))
    .pipe(minifyCss())
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});
```

3. You can target specific browsers by using the following:

```jsx

    .pipe(autoPrefixer({
        browsers: ['last 2 versions', 'ie 8']
    }))
```

# 3. Handling-Errors (Gulp-Plumber)

```bash
npm install gulp-plumber --save-dev
```

Integrating this into your task should look something like this - Be sure to run this before all of your other plugin's.

```jsx
.pipe(plumber(function (err) {
        console.log('Styles Task Error');
        console.log(err);
        this.emit('end');
    }))
```

# 4. SourceMaps

<aside>
💡 install the package

</aside>

```bash
npm install gulp-sourcemaps@1.6.0 --save-dev
```

In gulpfile.js - It must be defined before your prefixer (it needs to know what the file looked like before & after prefixer & minify)

<aside>
💡 This package will help you debug- It shows you where all the information came from.

</aside>

```jsx
gulp.task('styles', function (){
    console.log('Starting Styles task');
    return gulp.src(['public/css/reset.css', CSS_PATH])
    .pipe(plumber(function (err) {
        console.log('Styles Task Error');
        console.log(err);
        this.emit('end');
    }))
    .pipe(sourcemaps.init())
    .pipe(autoPrefixer({
        browsers: ['last 2 versions', 'ie 8']
    }))
    .pipe(concat('styles.css'))
    .pipe(minifyCss())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});
```

# 5. Sass & Scss

<aside>
💡 Import the package

</aside>

```bash
npm install gulp-sass --save-dev
```

Example of code.

```jsx
// Styles for SCSS
gulp.task('styles', function (){
    console.log('Starting Styles task');
    return gulp.src('public/scss/styles.scss')
    .pipe(plumber(function (err) {
        console.log('Styles Task Error');
        console.log(err);
        this.emit('end');
    }))
    .pipe(sourcemaps.init())
    .pipe(autoPrefixer({
        browsers: ['last 2 versions', 'ie 8']
    }))
    .pipe(sass({
        outputStyle: 'compressed'
    }))
    .pipe(sass())
    .pipe(minifyCss())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});
```

Example of watch task

```jsx
// Watch task
gulp.task('watch', function () {
    console.log('Starting Watch Task');
    require('./server.js');
    livereload.listen();
    gulp.watch(SCRIPTS_PATH, ['scripts']);
    // gulp.watch(CSS_PATH, ['styles']);
    gulp.watch('public/scss/**/*.scss', ['styles']);
});
```

# 6. Concat

<aside>
💡 Install the following into the root of your project

</aside>

```bash
npm install gulp-concat@2.6.0 --save-dev
```

BASIC FUNCTION

```jsx
gulp.task('styles', function (){
    console.log('Starting Styles task');
    return gulp.src(['public/css/reset.css', CSS_PATH])
    .pipe(concat('styles.css'))
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});
```

# 7. Babel

var babel = require(‘gulp-babel’);

install babel

```
npm install --save-d gulp-babel @bable/core @babel/preset-env
```

<aside>
💡 Basic Example of task

</aside>

```jsx
.pipe(babel({
        presets: ['@babel/env']
      }))
```

<aside>
💡 Full Example of task

</aside>

```jsx
gulp.task('scripts', function() {
    console.log('starting scripts task');
    return gulp.src('public/scripts/*.js')
      .pipe(plumber(function(err){
        console.log('Styles Task Error');
        console.log(err);
        this.emit('end');
      }))
      .pipe(sourcemaps.init())
      .pipe(babel({
        presets: ['@babel/env']
      }))
      .pipe(uglify())
      .pipe(concat('scripts.js'))
      .pipe(sourcemaps.write())
      .pipe(gulp.dest(DIST_PATH))
      .pipe(livereload());
  });
```

# 8. Static-Server & Live-Reload

### ServerSetup.

Install the npm package

```bash
npm install static-server@VERSION NUMBER --save
```

save a new JS file in the root of the project called `server.js`

```jsx
var StaticServer = require('static-server');

var server = new StaticServer({
    rootPath: './public/',
    port: 3000
})

server.start(function () {
    console.log('Server started on port ' + server.port);
});
```

### LiveReload.

Instlal the npm package

```bash
npm install gulp-livereload@{VERSION} --save-dev
```

You need to add the folloing line of code to any `HTML` pages which you wish to have a livereload `<script src="<http://localhost:35729/livereload.js>"></script>`

Add the following information to your `gulpfile.js`

```jsx
// Watch task
gulp.task('watch', ['default'], function () {
    console.log('Starting Watch Task');
    require('./server.js');
    livereload.listen();
    gulp.watch(SCRIPTS_PATH, ['scripts']);
    // gulp.watch(CSS_PATH, ['styles']);
    gulp.watch('public/scss/**/*.scss', ['styles']);
    gulp.watch(TEMPLATES_PATH, ['templates']);
});
```

# 9. HandleBars

```bash
npm install --save-dev gulp-wrap gulp-declare gulp-handlebars handlebars
```

```jsx
gulp.task('templates', function () {
	return gulp.src(TEMPLATES_PATH)
    .pipe(handlebars({
        handlebars: handlebarsLib
    }))
    .pipe(wrap('Handlebars.template(<%= contents %>)'))
    .pipe(declare({
        namespace: 'templates',
        noRedeclare: true
    }))
    .pipe(concat('templates.js'))
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});
```

# 10. Config

### NPM ITEMS NEEDED

```jsx
var gulp = require('gulp');
var uglify = require('gulp-uglify');
var livereload = require('gulp-livereload');
var concat = require('gulp-concat');
var minifyCss = require('gulp-clean-css');
```

e.g.

```bash
npm install gulp-uglify --save-dev
```

### Configurations

```jsx
// Styles
gulp.task('styles', function (){
    console.log('Starting Styles task');
    return gulp.src(['public/css/reset.css', CSS_PATH])
    .pipe(concat('styles.css'))
    .pipe(minifyCss())
    .pipe(gulp.dest(DIST_PATH))
    .pipe(livereload());
});

// Scripts
gulp.task('scripts', function (){
    console.log('Starting Scripts Task');

    return gulp.src(SCRIPTS_PATH)
        .pipe(uglify())
        .pipe(gulp.dest(DIST_PATH))
        .pipe(livereload());
});

// Images
gulp.task('images', function(){
    console.log('Starting Images Task')
});

gulp.task('default', function() {
    console.log('Starting Default Task');
});

// Watch task
gulp.task('watch', function () {
    console.log('Starting Watch Task');
    require('./server.js');
    livereload.listen();
    gulp.watch(SCRIPTS_PATH, ['scripts']);
    gulp.watch(CSS_PATH, ['styles']);
});
```