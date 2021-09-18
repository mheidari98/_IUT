
from mininet.topo import Topo
from itertools import combinations

class MyTopo( Topo ):
    "Simple topology example."

    def build( self, count=11 ):
        "Create custom topo."

        # Add hosts and switches
        hosts = [ self.addHost( 'h%d' % i ) for i in range( 1, count+1 ) ]
        switchs = [ self.addSwitch( 's%d' % i ) for i in range( 1, count+1 ) ]
        # Add links

        for h, s in zip(hosts, switchs):
                self.addLink( h, s )

        for l, r in combinations(switchs, 2):
                self.addLink( l, r )

topos = { 'mytopo': ( lambda: MyTopo() ) }
