//
//  Questions.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import Foundation

struct ValueItem {
    var axis: String
    var value: Int
}

struct Question {
    var questionText: String
    var answer: Double
    var valuesYes: [ValueItem]
    var valuesNo: [ValueItem]
    var imageName: String
}

let questionTexts: [String : String] = [
    "qc0":  "“One is not born, but rather becomes, a woman.”", // *
    "qc1": "Differences of treatement and quality of life in our society show that racism is still omnipresent.", // *
    "qc2": "All sciences, even chemistry and biology are not uncompromising and are conditioned by our society.", // *
    "qc3": "The categories “women” and “men” are social constructs that should be given up.", // *
    "qc4": "Nobody is by nature predisposed to criminality.", // *
    "qc5": "Sexual orientation is a social construct.", // *
    "qc6": "Social differences between ethnic groups cannot be explained by biology.", // *
    "qc7": "The social roles of women and men can partly be explained by biological differences.", // *
    "qc8": "Hormonal differences can explain some differences in individual characteristics between women and men.", // *
    "qc9": "Sexual assaults are partly caused by men's natural impulse.", // *
    "qc10": "Transgender individuals will never really be of the gender they would like to be.", // *
    "qc11": "Members of a nation or culture have some unchangeable characteristics that define them.", // *
    "qc12": "Biologically, human beings are designed for heterosexuality.", // *
    "qc13": "Selfishness is the overriding drive in the human species, no matter the context.", // *
    "qb0": "Borders should eventually be abolished.", // *
    "qb1": "People need to stand up for their ideals, even if it leads them to betray their country.", // *
    "qb2": "My country must pay for the damages caused by the crimes it commited in other countries.", // *
    "qb3": "If two countries have similar economies, social systems and environmental norms, then the free market between them has no negative impact.", // *
    "qb4": "National Chauvinism during sport competitions is not acceptable.", // *
    "qb5": "I am equally concerned about the inhabitants of my country and those of other the countries.", // *
    "qb6": "Foreigners living in my country should be allowed to act politically, equally to those who have the nationality.", // *
    "qb7": "Citizens should take priority over foreigners.", // *
    "qb8": "The values of my country are superior to those of other countries.", // *
    "qb9": "Multiculturalism is a threat to our society.", // *
    "qb10": "A good citizen is a patriot.", // *
    "qb11": "It is legitimate for a country to intervene militarily to defend its economic interests.", // *
    "qb12": "It is necessary to teach history in order to create a sense of belonging to the nation.", // *
    "qb13": "Research produced by my country should not be available to other countries.", // *
    "qp0": "No one should get rich from owning a business, housing, or land.", // *
    "qp1": "Wages by private firms is stealing from the workers.", // *
    "qp2": "It is important that health should stay a public matter.", // *
    "qp3": "Energy and transport structures should be a public matter.", // *
    "qp4": "Patents should not exist.", // *
    "qp5": "It is necessary to implement assemblies to ration our production to the consumers according to their needs.", // *
    "qp6": "The labor market enslave workers.", // *
    "qp7": "Looking for one's own profit is healthy for the economy.", // *
    "qp8": "It is merit that explains differences of wealth between two individuals.", // *
    "qp9": "The fact that some schools and universities are private is not a problem.", // *
    "qp10": "Delocalization is a necessary evil to improve production.",
    "qp11": "It is acceptable that there are rich and poor people.",
    "qp12": "It is acceptable that some industry sectors are private.",
    "qp13": "Banks should remain private.",
    "qm0": "Revenues and capital should be taxed to redistribute wealth.",
    "qm1": "The age of retirement should be lowered.",
    "qm2": "Dismissals of employees should be forbidden except if it is justified.",
    "qm3": "Minimal levels of salary should be ensured to make sure that a worker can live of her/his work.",
    "qm4": "It is necessary to avoid private monopoly.",
    "qm5": "Loans contracted in the public sphere (State, regions, collectivities...) should not necessarily be refunded.",
    "qm6": "Some sectors or type of employment should be financially supported.",
    "qm7": "Market economy is optimal when it is not regulated.",
    "qm8": "Nowadays employees are free to choose when signing a contract with their future employer",
    "qm9": "It is necessary to remove regulations in labour legislation to encourage firms to hire.",
    "qm10": "Legal work time should be increased.",
    "qm11": "Environmental norms should be influenced by mass consumption and not from an authority.",
    "qm12": "Social assistance deters people from working.",
    "qm13": "State-run companies should be managed like private ones and follow the logic of the market (competition, profitability...).",
    "qs0": "Traditions should be questioned.",
    "qs1": "I do not have any problem if other official languages are added or replace the already existing official language in my country.",
    "qs2": "Marriage should be abolished.",
    "qs3": "Foreigners enrich our culture.",
    "qs4": "The influence of religion should decrease.",
    "qs5": "A language is defined by its users, not by scholars.",
    "qs6": "Euthanasia should be authorised.",
    "qs7": "Homosexuals should not be treated equally to heterosexuals treatment regarding marriage, filiation, adoption or procreation.",
    "qs8": "In some specific conditions, the death penalty is justified.",
    "qs9": "Technical progress should not change society too quickly.",
    "qs10": "School should mostly teach our values, traditions and fundamental knowledge.",
    "qs11": "Abortion should be limited to specific cases.",
    "qs12": "The main goal of a couple is to make at least one child.",
    "qs13": "Abstinence should be prefered to contraception, to preserve the true nature of the sexual act.",
    "qe0": "It is not acceptable that human actions should lead to the extinction of species.",
    "qe1": "GMOs should be forbidden outside research and medical purposes.",
    "qe2": "We must fight against global warming.",
    "qe3": "We should accept changes in our way of consuming food to limit the exploitation of nature.",
    "qe4": "It is important to encourage an agriculture that maintains a food biodiversity, even if the output is inferior.",
    "qe5": "Preserving non urban ecosystems is more important than creating jobs.",
    "qe6": "Reduction of waste should be done by reducing production.",
    "qe7": "Space colonization is a good alternative to supply the lack of raw material on Earth (rare metals, oil...)",
    "qe8": "Transforming ecosystems durably to increase the quality of life of human beings is legitimate.",
    "qe9": "It is necessary to massively invest in research to improve productivity.",
    "qe10": "Transhumanism will be beneficial because it will allow us to improve our capacities.",
    "qe11": "Nuclear fission, when well maintained, is a good source of energy.",
    "qe12": "Exploitation of fossil fuels is necessary.",
    "qe13": "Maintaining strong economic growth should be an objective for the government.",
    "qj0": "Prisons should no longer exist.",
    "qj1": "It is unfair to set a minimal penalty for an offense or a crime.",
    "qj2": "Individuals who get out of prison should be accompanied in their reinsertion.",
    "qj3": "Justice should always take into consideration the context and the past of the condemned and adapt their penalty accordingly.",
    "qj4": "Conditions of life in jail should be greatly improved.",
    "qj5": "The filing and storage of personal records should be delimited strictly and database cross-checking should be forbidden.",
    "qj6": "The right to be anonymous on Internet should be guaranteed.",
    "qj7": "The purposeof the judiciary system should be to punish those who went against the law.",
    "qj8": "The police should be armed.",
    "qj9": "The sacrifice of some civil liberties is a necessity in order to be protected from terrorist acts.",
    "qj10": "Order and authority should be respected in all circumstances.",
    "qj11": "Heavy penalties are efficient because they are dissuasive.",
    "qj12": "It is better to arrest someone potentially dangerous preventively rather than taking the risk of having them committing a crime.",
    "qt0": "Mass strike is a good way to acquire new rights.",
    "qt1": "Armed struggle in a country is sometimes necessary.",
    "qt2": "Insurrection is necessary to deeply change society.",
    "qt3": "Activism in existing political organisations is not relevant to change society.",
    "qt4": "Elections organised by the state cannot question the powers in place.",
    "qt5": "Hacking has a legitimate place in political struggle.",
    "qt6": "Sabotage is legitimate under certain conditions.",
    "qt7": "Activists must always act in strict accordance with the law.",
    "qt8": "Revolutions will always end up in a bad way.",
    "qt9": "Changing the system radically is counter-productive. We should rather transform it progressively.",
    "qt10": "Violence against individuals is never productive.",
    "qt11": "We should always break with protestors who use violence.",
    "qt12": "We need to make compromises with the opposition to apply our ideas.",
    "qt13": "Changes in an individual's way of life can induce changes in society.",
    "qreli": "My religion must be spread as widely as possible.",
    "qcons": "It is a small group that consciously and secretly controls the world.",
    "qprag": "A good policy is a pragmatic policy without ideology.",
    "qmona": "We need to establish a monarchy to federate the people and preserve our sovereignty.",
    "qvega": "Humans should neither eat nor exploit animals.",
    "qanar": "The State should be abolished."
]

let questions: [Question] = [
    // Constructivism : Essentialism
    Question(questionText: questionTexts["qc0"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3), ValueItem(axis: "femi", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc0-woman"),
    Question(questionText: questionTexts["qc1"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc1-black"),
    Question(questionText: questionTexts["qc2"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc2-biology"),
    Question(questionText: questionTexts["qc3"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3), ValueItem(axis: "femi", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc3-gender"),
    Question(questionText: questionTexts["qc4"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc4-criminal"),
    Question(questionText: questionTexts["qc5"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc5-lgbt"),
    Question(questionText: questionTexts["qc6"]!, answer: 0, valuesYes: [ValueItem(axis: "c0", value: 3)], valuesNo: [ValueItem(axis: "c1", value: 3)], imageName: "qc6-ethnic"),
    Question(questionText: questionTexts["qc7"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3), ValueItem(axis: "femi", value: 3)], imageName: "qc7-chromosome"),
    Question(questionText: questionTexts["qc8"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3), ValueItem(axis: "femi", value: 3)], imageName: "qc8-hormone"),
    Question(questionText: questionTexts["qc9"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3), ValueItem(axis: "femi", value: 3)], imageName: "qc9-sex"),
    Question(questionText: questionTexts["qc10"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3)], imageName: "qc10-transgender"),
    Question(questionText: questionTexts["qc11"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3)], imageName: "qc11-culture"),
    Question(questionText: questionTexts["qc12"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3)], imageName: "qc12-heterosexual"),
    Question(questionText: questionTexts["qc13"]!, answer: 0, valuesYes: [ValueItem(axis: "c1", value: 3)], valuesNo: [ValueItem(axis: "c0", value: 3)], imageName: "qc13-wingsuit"),
    // Internationalism : Nationalism
    Question(questionText: questionTexts["qb0"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb0-passport"),
    Question(questionText: questionTexts["qb1"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb1-flag"),
    Question(questionText: questionTexts["qb2"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb2-bomb"),
    Question(questionText: questionTexts["qb3"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb3-currency"),
    Question(questionText: questionTexts["qb4"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb4-podium"),
    Question(questionText: questionTexts["qb5"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb5-africa"),
    Question(questionText: questionTexts["qb6"]!, answer: 0, valuesYes: [ValueItem(axis: "b0", value: 3)], valuesNo: [ValueItem(axis: "b1", value: 3)], imageName: "qb6-vote"),
    Question(questionText: questionTexts["qb7"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb7-id"),
    Question(questionText: questionTexts["qb8"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb8-medal"),
    Question(questionText: questionTexts["qb9"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb9-multicultural"),
    Question(questionText: questionTexts["qb10"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb10-heart"),
    Question(questionText: questionTexts["qb11"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb11-war"),
    Question(questionText: questionTexts["qb12"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb12-book"),
    Question(questionText: questionTexts["qb13"]!, answer: 0, valuesYes: [ValueItem(axis: "b1", value: 3)], valuesNo: [ValueItem(axis: "b0", value: 3)], imageName: "qb13-drug"),
    // Communism : Capitalism
    Question(questionText: questionTexts["qp0"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp0-wallet"),
    Question(questionText: questionTexts["qp1"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp1-salary"),
    Question(questionText: questionTexts["qp2"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp2-medicine"),
    Question(questionText: questionTexts["qp3"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp3-petroleum"),
    Question(questionText: questionTexts["qp4"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp4-patent"),
    Question(questionText: questionTexts["qp5"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp5-factory"),
    Question(questionText: questionTexts["qp6"]!, answer: 0, valuesYes: [ValueItem(axis: "p0", value: 3)], valuesNo: [ValueItem(axis: "p1", value: 3)], imageName: "qp6-interview"),
    Question(questionText: questionTexts["qp7"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "qp7-coin"),
    Question(questionText: questionTexts["qp8"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "qp8-diamond"),
    Question(questionText: questionTexts["qp9"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "qp9-school"),
    Question(questionText: questionTexts["qp10"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qp11"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qp12"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qp13"]!, answer: 0, valuesYes: [ValueItem(axis: "p1", value: 3)], valuesNo: [ValueItem(axis: "p0", value: 3)], imageName: "dna"),
    // Regulationism : Laissez-faire
    Question(questionText: questionTexts["qm0"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm1"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm2"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm3"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm4"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm5"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm6"]!, answer: 0, valuesYes: [ValueItem(axis: "m0", value: 3)], valuesNo: [ValueItem(axis: "m1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm7"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm8"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm9"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm10"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm11"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm12"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qm13"]!, answer: 0, valuesYes: [ValueItem(axis: "m1", value: 3)], valuesNo: [ValueItem(axis: "m0", value: 3)], imageName: "dna"),
    // Progressism : Conservatism
    Question(questionText: questionTexts["qs0"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs1"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs2"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3), ValueItem(axis: "femi", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs3"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs4"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs5"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs6"]!, answer: 0, valuesYes: [ValueItem(axis: "s0", value: 3)], valuesNo: [ValueItem(axis: "s1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs7"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs8"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3), ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3), ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs9"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs10"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs11"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3), ValueItem(axis: "femi", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs12"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qs13"]!, answer: 0, valuesYes: [ValueItem(axis: "s1", value: 3)], valuesNo: [ValueItem(axis: "s0", value: 3)], imageName: "dna"),
    // Ecology : Productivism
    Question(questionText: questionTexts["qe0"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe1"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe2"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe3"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe4"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe5"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe6"]!, answer: 0, valuesYes: [ValueItem(axis: "e0", value: 3)], valuesNo: [ValueItem(axis: "e1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe7"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe8"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe9"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe10"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe11"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe12"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qe13"]!, answer: 0, valuesYes: [ValueItem(axis: "e1", value: 3)], valuesNo: [ValueItem(axis: "e0", value: 3)], imageName: "dna"),
    // Rehabilitative justice : Punitive justice
    Question(questionText: questionTexts["qj0"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj1"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj2"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj3"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj4"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj5"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj6"]!, answer: 0, valuesYes: [ValueItem(axis: "j0", value: 3)], valuesNo: [ValueItem(axis: "j1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj7"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj8"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj9"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj10"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj11"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qj12"]!, answer: 0, valuesYes: [ValueItem(axis: "j1", value: 3)], valuesNo: [ValueItem(axis: "j0", value: 3)], imageName: "dna"),
    // Revolution : Reformism
    Question(questionText: questionTexts["qt0"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt1"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt2"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt3"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt4"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt5"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt6"]!, answer: 0, valuesYes: [ValueItem(axis: "t0", value: 3)], valuesNo: [ValueItem(axis: "t1", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt7"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt8"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt9"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt10"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt11"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt12"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    Question(questionText: questionTexts["qt13"]!, answer: 0, valuesYes: [ValueItem(axis: "t1", value: 3)], valuesNo: [ValueItem(axis: "t0", value: 3)], imageName: "dna"),
    // Bonus
    Question(questionText: questionTexts["qreli"]!, answer: 0, valuesYes: [ValueItem(axis: "reli", value: 3)], valuesNo: [], imageName: "dna"),
    Question(questionText: questionTexts["qcons"]!, answer: 0, valuesYes: [ValueItem(axis: "comp", value: 3)], valuesNo: [], imageName: "dna"),
    Question(questionText: questionTexts["qprag"]!, answer: 0, valuesYes: [ValueItem(axis: "prag", value: 3)], valuesNo: [], imageName: "dna"),
    Question(questionText: questionTexts["qmona"]!, answer: 0, valuesYes: [ValueItem(axis: "mona", value: 3)], valuesNo: [], imageName: "dna"),
    Question(questionText: questionTexts["qvega"]!, answer: 0, valuesYes: [ValueItem(axis: "vega", value: 3)], valuesNo: [], imageName: "dna"),
    Question(questionText: questionTexts["qanar"]!, answer: 0, valuesYes: [ValueItem(axis: "anar", value: 3)], valuesNo: [], imageName: "dna")
]
