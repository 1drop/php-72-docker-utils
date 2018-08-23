FROM webdevops/php:7.2

ENV GIT_LFS_VERSION=2.3.4

RUN apt-get update -yqq
RUN apt-install ansible
RUN ansible-galaxy install ansistrano.deploy,1.12.0 ansistrano.rollback,1.5.0
# Add git lfs
RUN curl -Lo git-lfs.tar.gz https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-amd64-${GIT_LFS_VERSION}.tar.gz \
    && tar xzf git-lfs.tar.gz && cd git-lfs-${GIT_LFS_VERSION} && ./install.sh && cd .. && rm -rf git-lfs*
# Add composer globals to PATH
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
# Add xml-linter
RUN composer global require mickaelandrieu/xml-linter
# Add phpunit
RUN curl -Lo /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/local/bin/phpunit
# Add php-cs-fixer
RUN curl -Lo /usr/local/bin/php-cs-fixer http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar && chmod +x /usr/local/bin/php-cs-fixer
# Add phpmd
RUN curl -Lo /usr/local/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar && chmod +x /usr/local/bin/phpmd
# Add phpcpd
RUN curl -Lo /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar && chmod +x /usr/local/bin/phpcpd
# Add security-checker
RUN curl -Lo /usr/local/bin/security-checker http://get.sensiolabs.org/security-checker.phar && chmod +x /usr/local/bin/security-checker
# Add phpstan
RUN composer global require phpstan/phpstan-shim
