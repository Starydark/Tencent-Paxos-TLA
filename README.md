# Tencent-Paxos-Tla

A project of using TLA+ to model the consensus algorithm in the paper [PaxosStore@VLDB2017](http://www.vldb.org/pvldb/vol10/p1730-lin.pdf) and the open-source [Tencent/paxosstore](https://github.com/Tencent/paxosstore).

TPaxos(the consensus algorithm above) is an variant of basic Paxos, and we uncover a crucial but sutble detail in TPaxos which is not fully clarified, called TPaxosAP. We establish refinement mapping from TPaxos to Voting and from TPaxosAP to EagerVoting(equivalent to Voting) to verify the correctness of TPaxos and TPaxosAP, Voting is a high-level spec in paper [Byzanting Paxos by Refinement](http://lamport.azurewebsites.net/pubs/web-byzpaxos.pdf).

### TLA+ module

- TPaxos.tla: the specification of TPaxos.
- TPaxosAP.tla: the specification of the variant of TPaxos.
- TPaxosWithVotes.tla: the refinement mapping of TPaxos refining Voting.
- TPaxosAPWithVotes.tla: the refinement mapping of TPaxosAP refining EagerVoting.
- EagerVoting.tla: a specification that is equivalent to Voting.  
- Voting.tla: a specification introduce by Lamport in paper [Byzanting Paxos by Refinement](http://lamport.azurewebsites.net/pubs/web-byzpaxos.pdf).
- Consensus.tla: a specification that implemented by Voting.

### Refinement relation

![](./fig/RefinementRelation.png)