class octobercms
{

	package { 'git-core':
    	ensure => present,
    }

	exec { 'clean www directory':
		command => "/bin/sh -c 'cd /var/www && find -mindepth 1 -delete'",
		unless => [ "test -f /var/www/composer.json", "test -d /var/www/app" ],
		require => Package['apache2']
	}

	file { '/var/www':
		mode => 0777
	}
}