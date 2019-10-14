---------------------- MODULE TPaxosWithVotes ------------------------
(*
We establish refinement mapping from TPaxos to Voting. 
*)
EXTENDS TPaxos

VARIABLE votes \*votes[q]: the set of votes cast by q \in Participant
varsV == <<vars, votes>>
-----------------------------------------------------------------------
InitV == 
    /\ Init 
    /\ votes = [q \in Participant |-> {}]
            
PrepareV(p, b) == 
    /\ Prepare(p, b)
    /\ votes' = votes
           
AcceptV(p, b, v) == 
    /\ Accept(p, b, v)
    /\ votes' = [votes EXCEPT ![p] = @ \cup {<<b, v>>}]\*collecting proposal <<b, v>>
                    
OnMessageV(q) == 
    /\ OnMessage(q)
    /\ IF state'[q][q].maxVBal # state[q][q].maxVBal \*accept
         THEN votes' = [votes EXCEPT ![q] = @ \cup \*collecting proposal
                                {<<state'[q][q].maxVBal, state'[q][q].maxVVal>>}]
         ELSE UNCHANGED votes
---------------------------------------------------------------------------                        
NextV == \E p \in Participant : 
                \/ OnMessageV(p)
                \/ \E b \in Ballot : \/ PrepareV(p, b)
                                     \/ \E v \in Value : AcceptV(p, b, v)
SpecV == InitV /\ [][NextV]_varsV

(***************************************************************************
  To verify Spec => Voting, we should define votes and maxBal
          votes,   \* votes[a] is the set of votes cast by Participant a
          maxBal   \* maxBal[a] is a ballot number.  Participant a will cast
                   \* further votes only in ballots numbered \geq maxBal[a]
 ***************************************************************************)
maxBal == [p \in Participant |-> state[p][p].maxBal]

V == INSTANCE Voting WITH Acceptor <- Participant 
                               (*votes <- votes, maxBal <- maxBal*)

THEOREM SpecV => V!Spec

=============================================================================
\* Modification History
\* Last modified Mon Sep 09 15:59:38 CST 2019 by stary
\* Created Mon Sep 02 15:47:52 GMT+08:00 2018 by stary
