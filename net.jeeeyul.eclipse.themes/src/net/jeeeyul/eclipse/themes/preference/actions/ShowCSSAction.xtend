package net.jeeeyul.eclipse.themes.preference.actions

import net.jeeeyul.eclipse.themes.css.CustomThemeGenerator
import net.jeeeyul.eclipse.themes.preference.JThemePreferenceStore
import net.jeeeyul.eclipse.themes.preference.internal.JTPreferencePage
import net.jeeeyul.swtend.SWTExtensions
import org.eclipse.jface.preference.PreferenceStore
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.StyledText
import net.jeeeyul.eclipse.themes.SharedImages

class ShowCSSAction extends AbstractPreferenceAction {
	new(JTPreferencePage page) {
		super(page)
		this.text = "Show CSS"
	}

	override run() {
		val extension SWTExtension = SWTExtensions.INSTANCE

		var tempStore = new JThemePreferenceStore(new PreferenceStore)
		page.saveTo(tempStore)

		var generator = new CustomThemeGenerator(tempStore)
		val css = generator.generate

		var shell = newShell(page.shell, SWT.APPLICATION_MODAL || SWT.SHELL_TRIM) [
			text = "CSS"
			image = SharedImages.getImage(SharedImages.JTHEME)
			background = COLOR_WHITE
			layout = newGridLayout[
				marginWidth = 5
				marginHeight = 5
			]
			new StyledText(it, SWT.READ_ONLY || SWT.MULTI || SWT.H_SCROLL || SWT.V_SCROLL) => [
				text = css
				background = COLOR_WHITE
				foreground = COLOR_BLACK
				layoutData = FILL_BOTH[
					widthHint = 640
					heightHint = 480
				]
			]
			pack
		]

		var shellBounds = shell.bounds
		shell.bounds = shellBounds.relocateCenterWith(page.shell.monitor.bounds.center)
		shell.open
	}

}
