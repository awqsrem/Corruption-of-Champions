/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualBFWhip extends Weapon {
		
		public function DualBFWhip() 
		{
			super("DBFWhip", "D.B.F.Whip", "dual big fucking whips", "a pair of big fucking whips", "whipping", 36, 2880, "Big Fucking Whips - the best solution for master tiny e-pen complex at this side of the Mareth!  This pair of 2H 5 meters long whips requires 225 (strength+speed) to fully unleash it power.", "Dual Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if ((game.player.str + game.player.spe) >= 225) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 27;
				else boost += 18;
			}
			if ((game.player.str + game.player.spe) >= 100) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 21;
				else boost += 12;
			}
			if ((game.player.str + game.player.spe) >= 75) {
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 15;
				else boost += 6;
			}
            if (((game.player.str + game.player.spe) < 75) && game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 9;
			return (9 + boost);
        }
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.DualWield) >= 0 && game.player.findPerk(PerkLib.GigantGrip) >= 0) return true;
			if (game.player.findPerk(PerkLib.DualWield) < 0) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those whips. Unless you want to hurt yourself instead enemies when trying to use them...  ");
			else outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}