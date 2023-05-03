# HomeLet Framework

# 1. Docker Container

### 1.1 Run and build the Container (FirstTime)

Run the container, mounting the relevant local directories using:

```bash
docker-compose up
```

# 2. Container Rebuild

### 2.1 After the container has been built once it can be rebuilt using:

```bash
docker-compose up --build
```

# 3. Additional Information

Open the homelet_framework.sh & ammend the following line of code

```bash
composer install
```

To

```bash
composer install --no-plugins --no-scripts
```

Amend the file path to efs_file_system: It will look something like this:

```bash
../../efs_file_system:/usr/var/homelet-framework/efs_file_system
```

# 4. Running HomeLet

If it has been built before you can just run

```bash
docker-compose up
```