# code

This repository contains a Dockerfile that sets up a containerized environment for running VS Code with tunnel support.

## Overview

The container provides a minimal Ubuntu-based environment with VS Code installed and configured for remote development using VS Code's tunnel feature.

## Features

- Based on Ubuntu latest
- VS Code installation with tunnel support
- Python virtual environment support
- Non-root user setup for security
- Minimal package installation

## Usage

### Building the Container

```bash
docker build -t vscode-tunnel .
```

### Running the Container

```bash
docker run -it vscode-tunnel
```

This will start VS Code in tunnel mode, allowing you to connect to your development environment remotely.

## Container Details

- Working Directory: `/code/data`
- User: `code` (UID: 65532)
- Main Command: VS Code tunnel

## Requirements

- Docker
- Internet connection for VS Code tunnel functionality

## Security Note

The container runs as a non-root user (UID: 65532) for enhanced security. 
