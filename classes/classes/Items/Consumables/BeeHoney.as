/**
 * Created by K.Quesom 11.06.14
 */
package classes.Items.Consumables
{
import classes.Appearance;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.*;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.Player;
import classes.PregnancyStore;
import classes.StatusEffects;
import classes.internals.Utils;

public class BeeHoney extends Consumable
    {
        private const PURE_HONEY_VALUE:int = 40;
        private const SPECIAL_HONEY_VALUE:int = 20;
		
        public function BeeHoney(pure:Boolean, special:Boolean) {
			var honeyName:String = special ? "SpHoney" : ((pure ? "PurHony" : "BeeHony"));
			var honeyLong:String = special ? "a bottle of special bee honey" : ((pure ? "a crystal vial filled with glittering honey" : "a small vial filled with giant-bee honey"));
			var honeyDesc:String = special ? "A clear crystal bottle of a dark brown fluid that you got from the bee handmaiden.  It gives off a strong sweet smell even though the bottle is still corked." : ("This fine crystal vial is filled with a thick amber liquid that glitters " + (pure ? "" : "dully ") + "in the light.  You can smell a sweet scent, even though it is tightly corked.");
			var honeyValue:int   = special ? SPECIAL_HONEY_VALUE : ((pure ? PURE_HONEY_VALUE : 6));
			super(
					honeyName,
					honeyName,
					honeyLong,
					honeyValue,
					honeyDesc
			);
        }
		
		override public function canUse():Boolean {
            if (value == SPECIAL_HONEY_VALUE && CoC.instance.player.statusEffectv1(StatusEffects.Exgartuan) == 1) { //Exgartuan doesn't like the special honey
                outputText("You uncork the bottle only to hear Exgartuan suddenly speak up.  <i>“Hey kid, this beautiful cock here doesn’t need any of that special bee shit.  Cork that bottle up right now or I’m going to make it so that you can’t drink anything but me.”</i>  You give an exasperated sigh and put the cork back in the bottle.");
				return false;
			}
			return true;
		}
		
		override public function useItem():Boolean {
            var player:Player = CoC.instance.player;
            var pure:Boolean = (value == PURE_HONEY_VALUE);
			var special:Boolean = (value == SPECIAL_HONEY_VALUE);
			var changes:Number = 0;
			var changeLimit:Number = 1;
			clearOutput();
			player.slimeFeed();
			//Chances of boosting the change limit.
			if (Utils.rand(2) == 0) changeLimit++;
			if (Utils.rand(2) == 0) changeLimit++;
			if (Utils.rand(2) == 0) changeLimit++;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Enhancement) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Fusion) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Enchantment) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Refinement) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Saturation) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Perfection) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.Creationism) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Drink text
			if (special) {
				outputText("You uncork the bottle and pour the incredibly strong smelling concentrated honey down your throat.  Its taste is also mighty intense.  All at once you feel the effects of the substance start to course through your body.");
			}
			else { //Text for normal or pure
				outputText("Opening the crystal vial, you are greeted by a super-concentrated wave of sweet honey-scent.  It makes you feel lightheaded.  You giggle and lick the honey from your lips, having drank down the syrupy elixir without a thought.");
			}
			player.refillHunger(15);
			if ((pure || special) && player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Pure or special honey can reduce the corruption of a phouka baby
                if (CoC.instance.flags[kFLAGS.PREGNANCY_CORRUPTION] > 1) { //Child is phouka, hates pure honey
                    outputText("\n\nYou feel queasy and want to throw up.  There's a pain in your belly and you realize the baby you're carrying didn't like that at all.  Then again, maybe pure honey is good for it.");
				}
                else if (CoC.instance.flags[kFLAGS.PREGNANCY_CORRUPTION] < 1) { //Child is faerie, loves pure honey
                    outputText("\n\nA warm sensation starts in your belly and runs all through your body.  It's almost as if you're feeling music and you guess your passenger enjoyed the meal.");
				}
				else { //Child is on the line, will become a faerie with this drink
					outputText("\n\nAt first you feel your baby struggle against the honey, then it seems to grow content and enjoy it.");
				}
                CoC.instance.flags[kFLAGS.PREGNANCY_CORRUPTION]--;
                if (pure) return(false); //No transformative effects for the player because the pure honey was absorbed by the baby - Special honey will keep on giving
			}
			//Corruption reduction
			if (changes < changeLimit && pure) { //Special honey will also reduce corruption, but uses different text and is handled separately
				outputText("\n\n");
				changes++;
				if (player.cor > 80) outputText("Your head aches, as if thunder was echoing around your skull.  ");
				else if (player.cor > 60) outputText("You feel a headache forming just behind your eyes.  In no time flat it reaches full strength.  ");
				else if (player.cor > 40) outputText("A wave of stinging pain slices through your skull.  ");
				else if (player.cor > 20) outputText("A prickling pain spreads throughout your skull.  ");
				else outputText("You feel a mildly unpleasant tingling inside your skull.  ");
				if (player.cor > 0) outputText("It quickly passes, leaving you more clearheaded");
				game.player.dynStats("cor", -(1 + (player.cor / 20)));
				//Libido Reduction
				if (player.cor > 0 && changes < changeLimit && Utils.rand(1.5) == 0 && player.lib > 40) {
					outputText(" and settling your overcharged sex-drive a bit.");
					game.player.dynStats("lib", -3, "lus", -20);
					changes++;
				}
				else if (player.cor > 0) outputText(".");
			}
			if (mutations.blockingBodyTransformations()) changeLimit = 0;
			//bee item corollary:
			if (changes < changeLimit && player.hairType == 4 && Utils.rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				outputText("\n\nAs you down the sticky-sweet honey, your head begins to feel heavier.  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels and smells like the honey you just ate; you watch as it dissolves into many thin strands coated in the sugary syrup.  <b>Your hair is back to normal (well, once you wash the honey out)!</b>");
				mutations.setHairType(Hair.NORMAL);
				changes++;
			}
			//(removes tentacle hair status, restarts hair growth if not prevented by reptile status)
			//Intelligence Boost
			if (changes < changeLimit && Utils.rand(2) == 0) {
				player.MutagenBonus("int", 0.1 * (80 - player.inte));
				outputText("\n\nYou spend a few moments analyzing the taste and texture of the honey's residue, feeling awfully smart.");
				changes++;
			}
			//Sexual Stuff
			//No idears
			//Appearance Stuff
			//Hair Color
			if (changes < changeLimit && (player.hairColor != "shiny black" && player.hairColor != "black and yellow") && player.lowerBody != LowerBody.GARGOYLE && player.hairLength > 10 && Utils.rand(5) == 0) {
				outputText("\n\nYou feel your scalp tingling, and you grab your hair in a panic, pulling a strand forward.  ");
				if (Utils.rand(9) == 0) player.hairColor = "black and yellow";
				else player.hairColor = "shiny black";
				outputText("Your hair is now [haircolor], just like a bee-girl's!");
				changes++;
			}
			//Hair Length
			if (changes < changeLimit && player.hairLength < 25 && player.lowerBody != LowerBody.GARGOYLE && Utils.rand(3) == 0) {
				outputText("\n\nFeeling a bit off-balance, you discover your hair has lengthened, ");
				player.hairLength += Utils.rand(4) + 1;
				outputText("becoming " + Appearance.hairDescription(player) + ".");
				changes++;
			}
			//-Remove extra breast rows
            if (changes < changeLimit && player.bRows() > 2 && Utils.rand(3) == 0 && !CoC.instance.flags[kFLAGS.HYPER_HAPPY]) {
                changes++;
				outputText("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + player.breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (player.bRows() >= 3) outputText("abdomen");
				else outputText("chest");
				outputText(". The " + Appearance.nippleDescription(player, player.breastRows.length - 1) + "s even fade until nothing but ");
				if (player.hasFur()) outputText(player.skin.coat.color + " " + player.skinDesc);
				else outputText(player.skinTone + " " + player.skinDesc);
				outputText(" remains. <b>You've lost a row of breasts!</b>");
				game.player.dynStats("sen", -5);
				player.removeBreastRow(player.breastRows.length - 1, 1);
			}
			//Antennae
			if (changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.antennae.type != Antennae.BEE && Utils.rand(3) == 0) {
				if (player.antennae.type == Antennae.MANTIS) outputText("\n\nYour head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.");
				else outputText("\n\nYour head itches momentarily as two floppy antennae sprout from your " + Appearance.hairDescription(player) + ".");
				mutations.setAntennae(Antennae.BEE);
				changes++;
			}
			//Horns
			if (changes < changeLimit && player.horns.count > 0 && player.lowerBody != LowerBody.GARGOYLE && Utils.rand(3) == 0) {
				outputText("\n\nYour horns crumble, falling apart in large chunks until they flake away to nothing.");
				mutations.setHornType(Horns.NONE);
				changes++;
			}
			// Chitin
			if (changes < changeLimit && (player.skin.coverage != Skin.COVERAGE_LOW || player.skin.coat.type != Skin.CHITIN || player.skin.coat.pattern != Skin.PATTERN_BEE_STRIPES)) {
				player.skin.growCoat(Skin.CHITIN,{
					color:"yellow",
					color2:"black",
					pattern:Skin.PATTERN_BEE_STRIPES
				},Skin.COVERAGE_LOW);
				// TODO grow chitin text
				if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedChitin)) {
					outputText("\n\n<b>Genetic Memory: Chitin - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedChitin, 0, 0, 0, 0);
				}
				changes++;
			}
			//Bee Legs
			if (changes < changeLimit
				&& player.lowerBody != LowerBody.BEE
				&& player.lowerBody != LowerBody.GARGOYLE
				&& Utils.rand(4) == 0) {
				outputText("\n\nYour legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once.  You scream in agony as you hear bones snapping and cracking.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.");
				mutations.setLowerBody(LowerBody.BEE);
				player.legCount = 2;
				changes++;
			}
			//(Arms to carapace-covered arms)
			if (player.arms.type != Arms.BEE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && Utils.rand(4) == 0) {
				outputText("\n\n");
				if (player.arms.type == Arms.SPIDER) outputText("On your upper arms slowly starting to grown yellow fuzz making them looks more like those of bee.");
				else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionaly on your upper arms appear yellow fuzz.");
				else {
					//(Bird pretext)
					if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
					outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.");
				}
				mutations.setArmType(Arms.BEE);
				changes++;
			}
			//-Nipples reduction to 1 per tit.
			if (player.averageNipplesPerBreast() > 1 && changes < changeLimit && Utils.rand(4) == 0) {
				outputText("\n\nA chill runs over your " + Appearance.allBreastsDescript(player) + " and vanishes.  You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ");
				if (player.biggestTitSize() < 1) outputText("'breast'.");
				else outputText("breast.");
				changes++;
				//Loop through and reset nipples
				for (var temp:int = 0; temp < player.breastRows.length; temp++) {
					player.breastRows[temp].nipplesPerBreast = 1;
				}
			}
			//Gain oviposition!
			if (changes < changeLimit && player.findPerk(PerkLib.BeeOvipositor) < 0 && player.tailType == Tail.BEE_ABDOMEN && Utils.rand(2) == 0) {
				outputText("\n\nAn odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous bee part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the stinger.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, black, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new bee ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Bee Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.BeeOvipositor, 0, 0, 0, 0);
				changes++;
			}
			//Bee butt - 66% lower chance if already has a tail
			if (changes < changeLimit && player.tailType != Tail.BEE_ABDOMEN && player.lowerBody != LowerBody.GARGOYLE && (player.tailType == Tail.NONE || Utils.rand(1.5) == 0) && Utils.rand(4) == 0) {
				if (player.tailType > Tail.NONE) outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.");
				else outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a bee's abdomen.</b>");
				mutations.setTailType(Tail.BEE_ABDOMEN,1);
				player.tailVenom = 10;
				player.tailRecharge = 5;
				changes++;
			}
			//Venom Increase
			if (changes < changeLimit && player.tailType == Tail.BEE_ABDOMEN && player.tailRecharge < 15 && Utils.rand(2)) {
				if (player.tailRecharge < 10) player.tailRecharge += 1;
				if (player.tailRecharge < 15) player.tailRecharge += 1;
				player.tailVenom += 50;
				if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
				outputText("\n\nYour abdomen swells with vitality and a drop of venom escapes your stinger as it begins producing it in slightly larger quantities.");
				changes++;
			}
			//Wings
			//Grow bigger bee wings!
			if (changes < changeLimit && player.wings.type == Wings.BEE_LIKE_SMALL && Utils.rand(4)) {
				changes++;
				mutations.setWingType(Wings.BEE_LIKE_LARGE, "large bee-like");
				outputText("\n\nYour wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly!  <b>You now have large bee wings!</b>  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.");
			}

			//Grow new bee wings if player has none.
			if (changes < changeLimit && player.wings.type == Wings.NONE && Utils.rand(4)) {
				changes++;
				outputText("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.  You hastily remove the top portion of your [armor] and marvel as a pair of small bee-like wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new bee wings</b>.");
				mutations.setWingType(Wings.BEE_LIKE_SMALL, "small bee-like");
			}
			//Melt demon wings!
			if (changes < changeLimit && player.wings.type != Wings.BEE_LIKE_SMALL && player.wings.type != Wings.BEE_LIKE_LARGE) {
				changes++;
				outputText("\n\nYour wings ripple, jelly-like.  Worried, you crane back to look, and to your horror, they're melting away!  Runnels of amber honey trail down the wings' edges, building into a steady flow.  <b>In a moment, the only remnant of your wings is a puddle of honey in the dirt</b>.  Even that is gone in seconds, wicked into the dry soil.");
				mutations.removeWings();
			}
			//Remove gills!
			if (Utils.rand(4) == 0 && player.hasGills() && changes < changeLimit) {
				if (player.gills.type == Gills.ANEMONE) outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				else outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.");
				outputText("  <b>You no longer have gills!</b>");
				mutations.updateGills(Gills.NONE);
				changes++;
			}

			if (special) { //All the special honey effects occur after any normal bee transformations (if the player wasn't a full bee morph)
				//Cock growth multiplier.
				var mult:int = 1.0;
				if (player.cocks[0].cArea() >= 140) mult -= 0.2;
				if (player.cocks[0].cArea() >= 180) mult -= 0.2;
				if (player.cocks[0].cArea() >= 220) mult -= 0.2;
				if (player.cocks[0].cArea() >= 260) mult -= 0.2;
				if (player.cocks[0].cArea() >= 300) mult -= 0.1;
				if (player.cocks[0].cArea() >= 400) mult -= 0.1; //Cock stops growing at that point.
				//Begin TF
				if (!player.hasCock()) {
					outputText("\n\nYou double over in pain as the effects start to concentrate into your groin.  You need to get release, but what you’ve got just isn’t cutting it.  You fall to the ground and grab at your crotch, trying desperately to get the release you need.  Finally, it happens.  With a sudden burst of intense relief and sexual satisfaction, a new human looking penis bursts from your skin and sprays your seed all over the ground in front of you.  When you’re able to recover and take a look at your new possession.  <b>You now have an eight inch long human cock that is very sensitive to stimulation.</b>");
					player.createCock();
					player.cocks[0].cockLength = Utils.rand(3) + 8;
					player.cocks[0].cockThickness = 2;
					player.orgasm();
					game.player.dynStats("sen", 10);
				}
				else if (player.cocks.length > 1) {
					var biggest:int = player.biggestCockIndex();
					outputText("\n\nThe effects of the honey move towards your groin, and into your [cocks], causing them to stand at attention.  They quiver for a moment, and feel rather itchy.  Suddenly you are overwhelmed with pleasure as <b>your " + player.cockDescript(biggest) + " is absorbed into your [cock]!</b>  You grab onto the merging cock and pump it with your hands as it increases in size and you cum in pleasure.  Your [cock] seems a lot more sensitive now...");
					player.cocks[0].cockLength		+= 5 * Math.sqrt(0.2 * player.cocks[biggest].cArea());
					player.cocks[0].cockThickness	+= Math.sqrt(0.2 * player.cocks[biggest].cArea());
					player.removeCock(biggest, 1);
					player.orgasm();
					game.player.dynStats("sen", 5);
				}
				else if (player.cocks[0].cArea() < 100) {
					outputText("\n\nYour [cock] suddenly becomes rock hard and incredibly sensitive to the touch.  You pull away your [armor], and start to masturbate furiously as it rapidly swells in size.  When the change finally finishes, you realize that your [cock] has both grown much longer and wider!  <b>");
					if (player.cocks[0].cArea() <= 20)
						outputText("It now swings as low as your knees!");
					else if (player.cocks[0].cArea() <= 50)
						outputText("While erect, your massive member fills the lower half of your vision.");
					else outputText("Your member is now simply huge, you wonder what in the world could actually take your massive size now?");
					outputText("</b>");
					player.cocks[0].cockLength += (Utils.rand(3) + 4) * mult; //4 to 6 inches in length
					player.cocks[0].cockThickness += (0.1 * Utils.rand(5) + 0.5) * mult; //0.5 to 1 inches in thickness
					game.player.dynStats("sen", 5);
				}
				else if (player.cocks[0].cockType != CockTypesEnum.BEE && player.race() == "bee-morph") {
					outputText("\n\nYour huge member suddenly starts to hurt, especially the tip of the thing.  At the same time, you feel your length start to get incredibly sensitive and the base of your shaft starts to itch.  You tear off your [armor] and watch in fascination as your [cock] starts to change.  The shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.\n\n");
					outputText("It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming, and it takes a lot of will not to just run off in search of the bee girl that gave you that special honey right now.  This isn’t good.\n\n");
					outputText("<b>You now have a bee cock!</b>");
					player.cocks[0].cockType = CockTypesEnum.BEE;
					player.cocks[0].cockLength += 5 * mult;
					player.cocks[0].cockThickness += 1 * mult;
					game.player.dynStats("sen", 15);
				}
				else {
					if (mult > 0) {
						outputText("\n\nThe effects of the honey don’t seem to focus on your groin this time, but you still feel your [cock] grow slightly under your [armor].");
						player.cocks[0].cockLength += (0.1 * Utils.rand(10) + 1) * mult;
						player.cocks[0].cockThickness += (0.1 * Utils.rand(2) + 0.1) * mult;
					}
					else {
						outputText("\n\nThe effects of the honey don’t seem to focus on your groin this time and you have a feeling that your " + player.cockDescript(0) + " hasn't grown at all! Perhaps you've reached the upper limit of cock growth from special honey?");
					}
					game.player.dynStats("sen", 3);
				}
				if (player.cor >= 5) {
					outputText("\n\nYour mind feels surprisingly clear of the twisted thoughts that have plagued it as of late, but you find yourself feeling more and more aroused than usual.");
					var corLoss:int = Math.min(0.1 * player.cor + 5, player.cor);
					game.player.dynStats("cor", -corLoss, "lib", corLoss); //Lose corruption and gains that much libido
				}
				else {
					outputText("\n\nYou find your mind is drifting to the thought of using your member to fertilize hundreds and hundreds of eggs every day.  You shake your head, the bizarre fantasy catching you completely off guard.");
					game.player.dynStats("cor=", 0, "lib", 5);
				}
				if (player.femininity >= 60 || player.femininity <= 40) {
					outputText("\n\nYour face shifts in shape, becoming more androgynous.");
					if (player.femininity >= 60)
						player.femininity -= 3;
					else player.femininity += 3;
				}
				game.player.dynStats("lust", 0.2 * player.lib + 5);
			}
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return(false);
		}
    }
}