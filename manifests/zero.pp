# See README.md 
define cvmfs::zero(
  $user,
  $uid,
  $repo = $title,
  $clientuser = $user,
  $group = $user,
  $gid = $uid,
  $nofiles = 65000,
  $repo_store = '/srv/cvmfs',
  $spool_store = '/var/spool/cvmfs',
  $home = "${repo_store}/${repo}/${user}",
  $claim_ownership = false,
  $auto_tag = true,
  $garbage_collection = false,
  $auto_gc = false,
  $auto_gc_timespan = '3 days ago',
  $ignore_xdir_hardlinks = false
) {
  include cvmfs::params
  include cvmfs::zero::install
  include cvmfs::zero::config
  include cvmfs::zero::service

  group{$group:
    gid => $gid
  }
  user{$user:
    uid        => $uid,
    gid        => $gid,
    comment    => "cvmfs shared account for repo ${repo}",
    managehome => true,
    home       => $home,
  }
  limits::entry{"${user}-soft": type => 'soft', item => 'nofile', value => $nofiles,  domain => $user}
  limits::entry{"${user}-hard": type => 'hard', item => 'nofile', value => $nofiles,  domain => $user}

  file{"/etc/cvmfs/repositories.d/${repo}":
    ensure  => directory,
    require => Package['cvmfs-server']
  }
  file{"/etc/cvmfs/repositories.d/${repo}/client.conf":
    ensure  => file,
    content => template('cvmfs/client.conf.erb')
  }
  file{"/etc/cvmfs/repositories.d/${repo}/server.conf":
    ensure  => file,
    content => template('cvmfs/server.conf.erb')
  }

  # Public repostory
  file{["${repo_store}/${repo}","${repo_store}/${repo}/data","${repo_store}/${repo}/data/txn"]:
    ensure => directory,
    owner  => $user,
    group  => $group
  }
  file{"${repo_store}/${repo}/.cvmfs_master_replica":
    ensure => file,
  }
  # THis is bad for so many reasons but it's very reliabe, we were
  # never in a hurry anyway. Role on puppet 4.

  if $::uptime_days <= 2 {
    file{["${repo_store}/${repo}/data/00",
      "${repo_store}/${repo}/data/01",
      "${repo_store}/${repo}/data/02",
      "${repo_store}/${repo}/data/03",
      "${repo_store}/${repo}/data/04",
      "${repo_store}/${repo}/data/05",
      "${repo_store}/${repo}/data/06",
      "${repo_store}/${repo}/data/07",
      "${repo_store}/${repo}/data/08",
      "${repo_store}/${repo}/data/09",
      "${repo_store}/${repo}/data/0a",
      "${repo_store}/${repo}/data/0b",
      "${repo_store}/${repo}/data/0c",
      "${repo_store}/${repo}/data/0d",
      "${repo_store}/${repo}/data/0e",
      "${repo_store}/${repo}/data/0f",
      "${repo_store}/${repo}/data/10",
      "${repo_store}/${repo}/data/11",
      "${repo_store}/${repo}/data/12",
      "${repo_store}/${repo}/data/13",
      "${repo_store}/${repo}/data/14",
      "${repo_store}/${repo}/data/15",
      "${repo_store}/${repo}/data/16",
      "${repo_store}/${repo}/data/17",
      "${repo_store}/${repo}/data/18",
      "${repo_store}/${repo}/data/19",
      "${repo_store}/${repo}/data/1a",
      "${repo_store}/${repo}/data/1b",
      "${repo_store}/${repo}/data/1c",
      "${repo_store}/${repo}/data/1d",
      "${repo_store}/${repo}/data/1e",
      "${repo_store}/${repo}/data/1f",
      "${repo_store}/${repo}/data/20",
      "${repo_store}/${repo}/data/21",
      "${repo_store}/${repo}/data/22",
      "${repo_store}/${repo}/data/23",
      "${repo_store}/${repo}/data/24",
      "${repo_store}/${repo}/data/25",
      "${repo_store}/${repo}/data/26",
      "${repo_store}/${repo}/data/27",
      "${repo_store}/${repo}/data/28",
      "${repo_store}/${repo}/data/29",
      "${repo_store}/${repo}/data/2a",
      "${repo_store}/${repo}/data/2b",
      "${repo_store}/${repo}/data/2c",
      "${repo_store}/${repo}/data/2d",
      "${repo_store}/${repo}/data/2e",
      "${repo_store}/${repo}/data/2f",
      "${repo_store}/${repo}/data/30",
      "${repo_store}/${repo}/data/31",
      "${repo_store}/${repo}/data/32",
      "${repo_store}/${repo}/data/33",
      "${repo_store}/${repo}/data/34",
      "${repo_store}/${repo}/data/35",
      "${repo_store}/${repo}/data/36",
      "${repo_store}/${repo}/data/37",
      "${repo_store}/${repo}/data/38",
      "${repo_store}/${repo}/data/39",
      "${repo_store}/${repo}/data/3a",
      "${repo_store}/${repo}/data/3b",
      "${repo_store}/${repo}/data/3c",
      "${repo_store}/${repo}/data/3d",
      "${repo_store}/${repo}/data/3e",
      "${repo_store}/${repo}/data/3f",
      "${repo_store}/${repo}/data/40",
      "${repo_store}/${repo}/data/41",
      "${repo_store}/${repo}/data/42",
      "${repo_store}/${repo}/data/43",
      "${repo_store}/${repo}/data/44",
      "${repo_store}/${repo}/data/45",
      "${repo_store}/${repo}/data/46",
      "${repo_store}/${repo}/data/47",
      "${repo_store}/${repo}/data/48",
      "${repo_store}/${repo}/data/49",
      "${repo_store}/${repo}/data/4a",
      "${repo_store}/${repo}/data/4b",
      "${repo_store}/${repo}/data/4c",
      "${repo_store}/${repo}/data/4d",
      "${repo_store}/${repo}/data/4e",
      "${repo_store}/${repo}/data/4f",
      "${repo_store}/${repo}/data/50",
      "${repo_store}/${repo}/data/51",
      "${repo_store}/${repo}/data/52",
      "${repo_store}/${repo}/data/53",
      "${repo_store}/${repo}/data/54",
      "${repo_store}/${repo}/data/55",
      "${repo_store}/${repo}/data/56",
      "${repo_store}/${repo}/data/57",
      "${repo_store}/${repo}/data/58",
      "${repo_store}/${repo}/data/59",
      "${repo_store}/${repo}/data/5a",
      "${repo_store}/${repo}/data/5b",
      "${repo_store}/${repo}/data/5c",
      "${repo_store}/${repo}/data/5d",
      "${repo_store}/${repo}/data/5e",
      "${repo_store}/${repo}/data/5f",
      "${repo_store}/${repo}/data/60",
      "${repo_store}/${repo}/data/61",
      "${repo_store}/${repo}/data/62",
      "${repo_store}/${repo}/data/63",
      "${repo_store}/${repo}/data/64",
      "${repo_store}/${repo}/data/65",
      "${repo_store}/${repo}/data/66",
      "${repo_store}/${repo}/data/67",
      "${repo_store}/${repo}/data/68",
      "${repo_store}/${repo}/data/69",
      "${repo_store}/${repo}/data/6a",
      "${repo_store}/${repo}/data/6b",
      "${repo_store}/${repo}/data/6c",
      "${repo_store}/${repo}/data/6d",
      "${repo_store}/${repo}/data/6e",
      "${repo_store}/${repo}/data/6f",
      "${repo_store}/${repo}/data/70",
      "${repo_store}/${repo}/data/71",
      "${repo_store}/${repo}/data/72",
      "${repo_store}/${repo}/data/73",
      "${repo_store}/${repo}/data/74",
      "${repo_store}/${repo}/data/75",
      "${repo_store}/${repo}/data/76",
      "${repo_store}/${repo}/data/77",
      "${repo_store}/${repo}/data/78",
      "${repo_store}/${repo}/data/79",
      "${repo_store}/${repo}/data/7a",
      "${repo_store}/${repo}/data/7b",
      "${repo_store}/${repo}/data/7c",
      "${repo_store}/${repo}/data/7d",
      "${repo_store}/${repo}/data/7e",
      "${repo_store}/${repo}/data/7f",
      "${repo_store}/${repo}/data/80",
      "${repo_store}/${repo}/data/81",
      "${repo_store}/${repo}/data/82",
      "${repo_store}/${repo}/data/83",
      "${repo_store}/${repo}/data/84",
      "${repo_store}/${repo}/data/85",
      "${repo_store}/${repo}/data/86",
      "${repo_store}/${repo}/data/87",
      "${repo_store}/${repo}/data/88",
      "${repo_store}/${repo}/data/89",
      "${repo_store}/${repo}/data/8a",
      "${repo_store}/${repo}/data/8b",
      "${repo_store}/${repo}/data/8c",
      "${repo_store}/${repo}/data/8d",
      "${repo_store}/${repo}/data/8e",
      "${repo_store}/${repo}/data/8f",
      "${repo_store}/${repo}/data/90",
      "${repo_store}/${repo}/data/91",
      "${repo_store}/${repo}/data/92",
      "${repo_store}/${repo}/data/93",
      "${repo_store}/${repo}/data/94",
      "${repo_store}/${repo}/data/95",
      "${repo_store}/${repo}/data/96",
      "${repo_store}/${repo}/data/97",
      "${repo_store}/${repo}/data/98",
      "${repo_store}/${repo}/data/99",
      "${repo_store}/${repo}/data/9a",
      "${repo_store}/${repo}/data/9b",
      "${repo_store}/${repo}/data/9c",
      "${repo_store}/${repo}/data/9d",
      "${repo_store}/${repo}/data/9e",
      "${repo_store}/${repo}/data/9f",
      "${repo_store}/${repo}/data/a0",
      "${repo_store}/${repo}/data/a1",
      "${repo_store}/${repo}/data/a2",
      "${repo_store}/${repo}/data/a3",
      "${repo_store}/${repo}/data/a4",
      "${repo_store}/${repo}/data/a5",
      "${repo_store}/${repo}/data/a6",
      "${repo_store}/${repo}/data/a7",
      "${repo_store}/${repo}/data/a8",
      "${repo_store}/${repo}/data/a9",
      "${repo_store}/${repo}/data/aa",
      "${repo_store}/${repo}/data/ab",
      "${repo_store}/${repo}/data/ac",
      "${repo_store}/${repo}/data/ad",
      "${repo_store}/${repo}/data/ae",
      "${repo_store}/${repo}/data/af",
      "${repo_store}/${repo}/data/b0",
      "${repo_store}/${repo}/data/b1",
      "${repo_store}/${repo}/data/b2",
      "${repo_store}/${repo}/data/b3",
      "${repo_store}/${repo}/data/b4",
      "${repo_store}/${repo}/data/b5",
      "${repo_store}/${repo}/data/b6",
      "${repo_store}/${repo}/data/b7",
      "${repo_store}/${repo}/data/b8",
      "${repo_store}/${repo}/data/b9",
      "${repo_store}/${repo}/data/ba",
      "${repo_store}/${repo}/data/bb",
      "${repo_store}/${repo}/data/bc",
      "${repo_store}/${repo}/data/bd",
      "${repo_store}/${repo}/data/be",
      "${repo_store}/${repo}/data/bf",
      "${repo_store}/${repo}/data/c0",
      "${repo_store}/${repo}/data/c1",
      "${repo_store}/${repo}/data/c2",
      "${repo_store}/${repo}/data/c3",
      "${repo_store}/${repo}/data/c4",
      "${repo_store}/${repo}/data/c5",
      "${repo_store}/${repo}/data/c6",
      "${repo_store}/${repo}/data/c7",
      "${repo_store}/${repo}/data/c8",
      "${repo_store}/${repo}/data/c9",
      "${repo_store}/${repo}/data/ca",
      "${repo_store}/${repo}/data/cb",
      "${repo_store}/${repo}/data/cc",
      "${repo_store}/${repo}/data/cd",
      "${repo_store}/${repo}/data/ce",
      "${repo_store}/${repo}/data/cf",
      "${repo_store}/${repo}/data/d0",
      "${repo_store}/${repo}/data/d1",
      "${repo_store}/${repo}/data/d2",
      "${repo_store}/${repo}/data/d3",
      "${repo_store}/${repo}/data/d4",
      "${repo_store}/${repo}/data/d5",
      "${repo_store}/${repo}/data/d6",
      "${repo_store}/${repo}/data/d7",
      "${repo_store}/${repo}/data/d8",
      "${repo_store}/${repo}/data/d9",
      "${repo_store}/${repo}/data/da",
      "${repo_store}/${repo}/data/db",
      "${repo_store}/${repo}/data/dc",
      "${repo_store}/${repo}/data/dd",
      "${repo_store}/${repo}/data/de",
      "${repo_store}/${repo}/data/df",
      "${repo_store}/${repo}/data/e0",
      "${repo_store}/${repo}/data/e1",
      "${repo_store}/${repo}/data/e2",
      "${repo_store}/${repo}/data/e3",
      "${repo_store}/${repo}/data/e4",
      "${repo_store}/${repo}/data/e5",
      "${repo_store}/${repo}/data/e6",
      "${repo_store}/${repo}/data/e7",
      "${repo_store}/${repo}/data/e8",
      "${repo_store}/${repo}/data/e9",
      "${repo_store}/${repo}/data/ea",
      "${repo_store}/${repo}/data/eb",
      "${repo_store}/${repo}/data/ec",
      "${repo_store}/${repo}/data/ed",
      "${repo_store}/${repo}/data/ee",
      "${repo_store}/${repo}/data/ef",
      "${repo_store}/${repo}/data/f0",
      "${repo_store}/${repo}/data/f1",
      "${repo_store}/${repo}/data/f2",
      "${repo_store}/${repo}/data/f3",
      "${repo_store}/${repo}/data/f4",
      "${repo_store}/${repo}/data/f5",
      "${repo_store}/${repo}/data/f6",
      "${repo_store}/${repo}/data/f7",
      "${repo_store}/${repo}/data/f8",
      "${repo_store}/${repo}/data/f9",
      "${repo_store}/${repo}/data/fa",
      "${repo_store}/${repo}/data/fb",
      "${repo_store}/${repo}/data/fc",
      "${repo_store}/${repo}/data/fd",
      "${repo_store}/${repo}/data/fe",
      "${repo_store}/${repo}/data/ff"]:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      require => File["${repo_store}/${repo}"]
    }
  }
  file{"/cvmfs/${repo}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => Package['cvmfs']
  }

  # Spool area
  file{"${spool_store}/${repo}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => Package['cvmfs-server']
  }
  file{["${spool_store}/${repo}/cache","${spool_store}/${repo}/rdonly","${spool_store}/${repo}/scratch","${spool_store}/${repo}/tmp"]:
    ensure => directory,
    owner  => $user,
    group  => $group
  }

  file{"/etc/httpd/conf.d/${repo}.conf":
    ensure  => file,
    content => template('cvmfs/zero-httpd.conf.erb'),
    require => Package['httpd'],
    notify  => Service['httpd']
  }
  mount{"${spool_store}/${repo}/rdonly":
    ensure  => present,
    device  => "cvmfs2#${repo}",
    fstype  => 'fuse',
    options => "allow_other,config=/etc/cvmfs/repositories.d/${repo}/client.conf:${spool_store}/${repo}/client.local,cvmfs_suid",
    require => File["${spool_store}/${repo}/rdonly"]
  }
  if $::kernelrelease =~ /^.*aufs.*/ {
    mount{"/cvmfs/${repo}":
      ensure  => present,
      device  => "aufs_${repo}",
      fstype  => 'aufs',
      options => "br=${spool_store}/${repo}/scratch=rw:${spool_store}/${repo}/rdonly=rr,udba=none,ro",
      require => [Package['cvmfs'],Mount["${spool_store}/${repo}/rdonly"],File["/cvmfs/${repo}"]]
    }
  }
  # Bootstrap first repository.
  file{"/etc/puppet-cvmfs-scripts/${repo}-create_repo.sh":
    ensure  => file,
    mode    => '0755',
    content => template('cvmfs/create_script.sh.erb')
  }
  # Scrip to generate keys.
  file{"/etc/puppet-cvmfs-scripts/${repo}-genkeys.sh":
    ensure  => file,
    mode    => '0755',
    content => template('cvmfs/genkeys.sh.erb')
  }
}
