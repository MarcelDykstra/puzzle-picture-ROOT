# Puzzle Picture — [ROOT framework (CERN)](https://root.cern/)

[![Puzzle Picture — ROOT](puzzle-picture-ROOT.png)](https://www.auger.org/)

```C++
#include <vector>
#include <ranges>
#include <TStyle.h>
#include <TCanvas.h>
#include <TH2F.h>
#include <TMarker.h>

int main() {
    const auto nContours = 20;  // Limit number of color-bins, independent of major-ticks in colorbar.

    gStyle->SetTitleBorderSize(1);  // Add a personal touch, with border around title.
    gStyle->SetTitleFontSize(0.035);
    gStyle->SetPalette(1);
    gStyle->SetNumberContours(nContours);
    gStyle->SetOptStat(0);

    std::vector<double> x = {0, 0, -160, 160, -160,  160,   0,    0, 320, -320, 240,  240, -240, -240};
    std::vector<double> y = {0, 0,  280, 280, -280, -280, 280, -280,   0,    0, 140, -140,  140, -140};
    std::vector<double> c = {0, 4,   10,   2, 17.5,    6,  12,    7,  16,    2,  15,    8,   16,    9};
    auto [cMin, cMax] = std::ranges::minmax(c);

    auto *canvas = new TCanvas("c1", "scatter plot", 800, 600);
    auto *frame = new TH2F("h1", "hexagonal grid (...). mean ... time;x [m];y [m]",
                           10, -325, 325, 10, -325, 325);

    frame->SetMinimum(cMin);
    frame->SetMaximum(cMax);
    frame->SetContour(nContours);
    frame->Draw("COLZ");

    auto pltSz = gStyle->GetNumberOfColors();
    for (size_t i = 0; i < c.size(); i++) {
        auto cIdx = ((c[i] - cMin) / (cMax - cMin)) * pltSz;
        auto cMrk = gStyle->GetColorPalette(cIdx);

        auto *marker = new TMarker(x[i], y[i], 21);
        marker->SetMarkerSize(0.7);
        marker->SetMarkerColor(cMrk);
        marker->Draw("SAME");
    }

    canvas->SaveAs("puzzle-picture-ROOT.png");
    return 0;
}
```

> Kant's Axe? (No background in grammar?): "_[Alleen **zij** die groots **durven** te falen, **kunnen** ooit groots bereiken.](https://citaten.net/quotes/robert_f_kennedy/40114/citaat-alleen-wie-het-aandurft-om-groots-te-falen-krijgt-de-kans-om.html)_" — Robert F. Kennedy

[References](REFERENCES.md)

[![puzzle-picture-ROOT — License](https://img.shields.io/badge/LICENSE-MIT-blue?style=for-the-badge)](LICENSE.md)
