FROM xukuanhit/air_slam:v4
ARG ROS_DISTRO=noetic

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# ===================
# Basic installation
# ===================
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo git vim tmux \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-desktop \
    python3-catkin-tools
RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/apt/apt.conf.d/docker-clean

# =====================
# Install ROS packages
# =====================
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-image-transport-plugins
RUN apt-get update && apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-tf

# ====================
# Change user to USER
# ====================
USER $USERNAME
ENV SHELL /bin/bash

# ======
# Setup
# ======
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ~/ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashrc
RUN echo "export ROS_WORKSPACE=~/ws" >> ~/.bashrc
RUN echo "export ROS_PACKAGE_PATH=~/ws/src:\$ROS_PACKAGE_PATH" >> ~/.bashrc

# ================
# Build AirSLAM
# ================
RUN mkdir -p ~/ws/src \
    && git clone https://github.com/sair-lab/AirSLAM.git /home/${USERNAME}/ws/src/AirSLAM
RUN cd ~/ws \
    && sudo ldconfig \
    && /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && catkin build -j4"

CMD ["/bin/bash"]
